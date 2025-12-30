-- ======================================================================================
-- 5. CHAT SYSTEM (Secure RLS)
-- ======================================================================================

CREATE TABLE public.conversations (
    id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
    type public.conversation_type NOT NULL,
    title VARCHAR(255),
    created_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE public.conversations ENABLE ROW LEVEL SECURITY;
-- No specific RLS on conversations itself, access is controlled by the participants table

CREATE TABLE public.conversation_participants (
    conversation_id UUID NOT NULL REFERENCES public.conversations(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    last_read_at TIMESTAMPTZ DEFAULT now(),
    joined_at TIMESTAMPTZ DEFAULT now(),
    PRIMARY KEY (conversation_id, user_id)
);

ALTER TABLE public.conversation_participants ENABLE ROW LEVEL SECURITY;

-- RLS POLICIES for participants
-- 1. Users can see all participants of a conversation they are in
CREATE POLICY "Users view chat peers" ON public.conversation_participants
FOR SELECT USING (
  EXISTS (
    SELECT 1 FROM public.conversation_participants as cp
    WHERE cp.conversation_id = conversation_participants.conversation_id
    AND cp.user_id = auth.uid()
  )
);
-- 2. Users can join/leave (INSERT/DELETE) their own rows.
CREATE POLICY "Users manage own participation" ON public.conversation_participants
FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);


CREATE TABLE public.messages (
    id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
    conversation_id UUID NOT NULL REFERENCES public.conversations(id) ON DELETE CASCADE,
    sender_id UUID NOT NULL REFERENCES public.users(id),
    content TEXT,
    attachment_url TEXT,
    created_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;

-- RLS POLICIES for messages (The most critical security layer)
-- 1. Read: You can only SELECT messages if you are a participant.
CREATE POLICY "Participants view messages" ON public.messages
FOR SELECT USING (
  EXISTS (
    SELECT 1 FROM public.conversation_participants
    WHERE conversation_id = messages.conversation_id
    AND user_id = auth.uid()
  )
);

-- 2. Write: You can only INSERT messages if you are a participant and the sender.
CREATE POLICY "Participants send messages" ON public.messages
FOR INSERT WITH CHECK (
  auth.uid() = sender_id AND
  EXISTS (
    SELECT 1 FROM public.conversation_participants
    WHERE conversation_id = messages.conversation_id
    AND user_id = auth.uid()
  )
);


-- Contexts Table (Links conversations to the entity: Group or Slot)
CREATE TABLE public.conversation_contexts (
    conversation_id UUID PRIMARY KEY REFERENCES public.conversations(id) ON DELETE CASCADE,
    group_id UUID REFERENCES public.groups(id) ON DELETE CASCADE,
    guide_activity_id UUID REFERENCES public.guide_activities(id),
    guide_slot_start_time TIMESTAMPTZ,

    CONSTRAINT check_context_exclusivity CHECK (
        (group_id IS NOT NULL AND guide_activity_id IS NULL) OR
        (group_id IS NULL AND guide_activity_id IS NOT NULL AND guide_slot_start_time IS NOT NULL)
    ),
    UNIQUE(group_id),
    UNIQUE(guide_activity_id, guide_slot_start_time)
);

ALTER TABLE public.conversation_contexts ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Contexts viewable by everyone" ON public.conversation_contexts FOR SELECT USING (true);


-- INDEXES
CREATE INDEX idx_messages_conversation ON public.messages(conversation_id, created_at DESC);
CREATE INDEX idx_participants_user ON public.conversation_participants(user_id);

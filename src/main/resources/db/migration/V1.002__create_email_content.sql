CREATE EXTENSION IF NOT EXISTS vector;

CREATE TABLE email_content (
    id BIGSERIAL PRIMARY KEY,
    fk_gmail_mailbox_id BIGINT NOT NULL,
    processed_status VARCHAR(32) NOT NULL DEFAULT 'EMAIL_RECEIVED',
    subject TEXT,
    from_address TEXT,
    to_address TEXT,
    cc_address TEXT,
    sent_at TIMESTAMPTZ,
    received_at TIMESTAMPTZ,
    sanitized_content_path VARCHAR(1024),
    raw_content_path VARCHAR(1024),
    raw_content_type VARCHAR(16) NOT NULL DEFAULT 'PENDING',
    origin VARCHAR(16),
    message_id VARCHAR(1024) NOT NULL,
    thread_id VARCHAR(1024) NOT NULL,
    parent_message_id VARCHAR(1024),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_email_content_mailbox
    FOREIGN KEY (fk_gmail_mailbox_id)
    REFERENCES gmail_mailbox(id)
    ON DELETE CASCADE,

    CONSTRAINT uq_email_content_message
    UNIQUE (fk_gmail_mailbox_id, message_id)
);

CREATE INDEX idx_email_content_mailbox
ON email_content(fk_gmail_mailbox_id);

CREATE INDEX idx_email_content_thread
ON email_content(thread_id);

CREATE INDEX idx_email_content_parent
ON email_content(parent_message_id);

CREATE INDEX idx_email_content_mailbox_status
ON email_content(fk_gmail_mailbox_id, processed_status);
CREATE TABLE email_attachment (
    id BIGSERIAL PRIMARY KEY,
    fk_gmail_mailbox_id BIGINT NOT NULL,
    fk_email_content_id BIGINT NOT NULL,
    email_attachment_id VARCHAR(1024),
    file_name VARCHAR(1024) NOT NULL,
    mime_type VARCHAR(255),
    size_in_bytes BIGINT,
    storage_path VARCHAR(1024),
    storage_provider VARCHAR(64) NOT NULL DEFAULT 'local',
    content_id VARCHAR(1024),
    is_inline BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_email_attachment_email_content
    FOREIGN KEY (fk_email_content_id)
    REFERENCES email_content(id)
    ON DELETE CASCADE
);

CREATE INDEX idx_email_attachment_email_content
ON email_attachment(fk_email_content_id);
CREATE TABLE cluster (
    id BIGSERIAL PRIMARY KEY,
    fk_gmail_mailbox_id BIGINT NOT NULL,
    cluster_index INT NOT NULL,
    email_count INT NOT NULL,
    centroid vector(1024) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT uq_cluster_mailbox_index
    UNIQUE (fk_gmail_mailbox_id, cluster_index),

    CONSTRAINT fk_cluster_mailbox
    FOREIGN KEY (fk_gmail_mailbox_id)
    REFERENCES gmail_mailbox(id)
    ON DELETE CASCADE
);

CREATE INDEX idx_cluster_mailbox
ON cluster(fk_gmail_mailbox_id);

CREATE INDEX idx_cluster_centroid
ON cluster
USING hnsw (centroid vector_cosine_ops);
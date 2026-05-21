CREATE TABLE cluster_label_map (
    id BIGSERIAL PRIMARY KEY,
    fk_gmail_mailbox_id BIGINT NOT NULL,
    fk_cluster_id BIGINT NOT NULL,
    fk_label_id BIGINT NOT NULL,
    mapping_score DOUBLE PRECISION,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_cluster_label_cluster
    FOREIGN KEY (fk_cluster_id)
    REFERENCES cluster(id)
    ON DELETE CASCADE,

    CONSTRAINT fk_cluster_label_label
    FOREIGN KEY (fk_label_id)
    REFERENCES label(id)
    ON DELETE CASCADE,

    CONSTRAINT uq_cluster_label
    UNIQUE (fk_cluster_id)
);

CREATE INDEX idx_cluster_label_cluster
ON cluster_label_map(fk_cluster_id);

CREATE INDEX idx_cluster_label_label
ON cluster_label_map(fk_label_id);
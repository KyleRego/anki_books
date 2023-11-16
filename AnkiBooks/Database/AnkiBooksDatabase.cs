using AnkiBooks.Models;

namespace AnkiBooks;

public partial class AnkiBooksDatabase : DbContext
{
    public AnkiBooksDatabase()
    {
    }

    public AnkiBooksDatabase(DbContextOptions<AnkiBooksDatabase> options)
        : base(options)
    {
    }

    public virtual DbSet<ActionTextRichText> ActionTextRichTexts { get; set; }

    public virtual DbSet<ActiveStorageAttachment> ActiveStorageAttachments { get; set; }

    public virtual DbSet<ActiveStorageBlob> ActiveStorageBlobs { get; set; }

    public virtual DbSet<ActiveStorageVariantRecord> ActiveStorageVariantRecords { get; set; }

    public virtual DbSet<ArInternalMetadatum> ArInternalMetadata { get; set; }

    public virtual DbSet<Article> Articles { get; set; }

    public virtual DbSet<BasicNote> BasicNotes { get; set; }

    public virtual DbSet<Book> Books { get; set; }

    public virtual DbSet<BooksUser> BooksUsers { get; set; }

    public virtual DbSet<ClozeNote> ClozeNotes { get; set; }

    public virtual DbSet<ClozeNotesConcept> ClozeNotesConcepts { get; set; }

    public virtual DbSet<Concept> Concepts { get; set; }

    public virtual DbSet<SchemaMigration> SchemaMigrations { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        // TODO: This check may not be needed
        if (!optionsBuilder.IsConfigured)
        {
            // TODO: Load connection string from a config file
            optionsBuilder.UseNpgsql("Host=localhost;Database=anki_books_development;Username=postgres;Password=password;");
        }
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder
            .HasPostgresExtension("fuzzystrmatch")
            .HasPostgresExtension("pgcrypto");

        modelBuilder.Entity<ActionTextRichText>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("action_text_rich_texts_pkey");

            entity.ToTable("action_text_rich_texts");

            entity.HasIndex(e => new { e.RecordType, e.RecordId, e.Name }, "index_action_text_rich_texts_uniqueness").IsUnique();

            entity.Property(e => e.Id)
                .HasDefaultValueSql("gen_random_uuid()")
                .HasColumnName("id");
            entity.Property(e => e.Body).HasColumnName("body");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("timestamp(6) without time zone")
                .HasColumnName("created_at");
            entity.Property(e => e.Name)
                .HasColumnType("character varying")
                .HasColumnName("name");
            entity.Property(e => e.RecordId).HasColumnName("record_id");
            entity.Property(e => e.RecordType)
                .HasColumnType("character varying")
                .HasColumnName("record_type");
            entity.Property(e => e.UpdatedAt)
                .HasColumnType("timestamp(6) without time zone")
                .HasColumnName("updated_at");
        });

        modelBuilder.Entity<ActiveStorageAttachment>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("active_storage_attachments_pkey");

            entity.ToTable("active_storage_attachments");

            entity.HasIndex(e => e.BlobId, "index_active_storage_attachments_on_blob_id");

            entity.HasIndex(e => new { e.RecordType, e.RecordId, e.Name, e.BlobId }, "index_active_storage_attachments_uniqueness").IsUnique();

            entity.Property(e => e.Id)
                .HasDefaultValueSql("gen_random_uuid()")
                .HasColumnName("id");
            entity.Property(e => e.BlobId).HasColumnName("blob_id");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("timestamp(6) without time zone")
                .HasColumnName("created_at");
            entity.Property(e => e.Name)
                .HasColumnType("character varying")
                .HasColumnName("name");
            entity.Property(e => e.RecordId).HasColumnName("record_id");
            entity.Property(e => e.RecordType)
                .HasColumnType("character varying")
                .HasColumnName("record_type");

            entity.HasOne(d => d.Blob).WithMany(p => p.ActiveStorageAttachments)
                .HasForeignKey(d => d.BlobId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_rails_c3b3935057");
        });

        modelBuilder.Entity<ActiveStorageBlob>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("active_storage_blobs_pkey");

            entity.ToTable("active_storage_blobs");

            entity.HasIndex(e => e.Key, "index_active_storage_blobs_on_key").IsUnique();

            entity.Property(e => e.Id)
                .HasDefaultValueSql("gen_random_uuid()")
                .HasColumnName("id");
            entity.Property(e => e.ByteSize).HasColumnName("byte_size");
            entity.Property(e => e.Checksum)
                .HasColumnType("character varying")
                .HasColumnName("checksum");
            entity.Property(e => e.ContentType)
                .HasColumnType("character varying")
                .HasColumnName("content_type");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("timestamp(6) without time zone")
                .HasColumnName("created_at");
            entity.Property(e => e.Filename)
                .HasColumnType("character varying")
                .HasColumnName("filename");
            entity.Property(e => e.Key)
                .HasColumnType("character varying")
                .HasColumnName("key");
            entity.Property(e => e.Metadata).HasColumnName("metadata");
            entity.Property(e => e.ServiceName)
                .HasColumnType("character varying")
                .HasColumnName("service_name");
        });

        modelBuilder.Entity<ActiveStorageVariantRecord>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("active_storage_variant_records_pkey");

            entity.ToTable("active_storage_variant_records");

            entity.HasIndex(e => new { e.BlobId, e.VariationDigest }, "index_active_storage_variant_records_uniqueness").IsUnique();

            entity.Property(e => e.Id)
                .HasDefaultValueSql("gen_random_uuid()")
                .HasColumnName("id");
            entity.Property(e => e.BlobId).HasColumnName("blob_id");
            entity.Property(e => e.VariationDigest)
                .HasColumnType("character varying")
                .HasColumnName("variation_digest");

            entity.HasOne(d => d.Blob).WithMany(p => p.ActiveStorageVariantRecords)
                .HasForeignKey(d => d.BlobId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_rails_993965df05");
        });

        modelBuilder.Entity<ArInternalMetadatum>(entity =>
        {
            entity.HasKey(e => e.Key).HasName("ar_internal_metadata_pkey");

            entity.ToTable("ar_internal_metadata");

            entity.Property(e => e.Key)
                .HasColumnType("character varying")
                .HasColumnName("key");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("timestamp(6) without time zone")
                .HasColumnName("created_at");
            entity.Property(e => e.UpdatedAt)
                .HasColumnType("timestamp(6) without time zone")
                .HasColumnName("updated_at");
            entity.Property(e => e.Value)
                .HasColumnType("character varying")
                .HasColumnName("value");
        });

        modelBuilder.Entity<Article>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("articles_pkey");

            entity.ToTable("articles");

            entity.HasIndex(e => new { e.OrdinalPosition, e.BookId }, "index_articles_on_ordinal_position_and_book_id").IsUnique();

            entity.Property(e => e.Id)
                .HasDefaultValueSql("gen_random_uuid()")
                .HasColumnName("id");
            entity.Property(e => e.BookId).HasColumnName("book_id");
            entity.Property(e => e.Complete).HasColumnName("complete");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("timestamp(6) without time zone")
                .HasColumnName("created_at");
            entity.Property(e => e.OrdinalPosition).HasColumnName("ordinal_position");
            entity.Property(e => e.Reading)
                .IsRequired()
                .HasDefaultValueSql("true")
                .HasColumnName("reading");
            entity.Property(e => e.System).HasColumnName("system");
            entity.Property(e => e.Title)
                .HasColumnType("character varying")
                .HasColumnName("title");
            entity.Property(e => e.UpdatedAt)
                .HasColumnType("timestamp(6) without time zone")
                .HasColumnName("updated_at");
            entity.Property(e => e.Writing).HasColumnName("writing");

            entity.HasOne(d => d.Book).WithMany(p => p.Articles)
                .HasForeignKey(d => d.BookId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_rails_99b5b2e73a");
        });

        modelBuilder.Entity<BasicNote>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("basic_notes_pkey");

            entity.ToTable("basic_notes");

            entity.HasIndex(e => e.AnkiGuid, "index_basic_notes_on_anki_guid").IsUnique();

            entity.HasIndex(e => new { e.OrdinalPosition, e.ArticleId }, "index_basic_notes_on_ordinal_position_and_article_id").IsUnique();

            entity.Property(e => e.Id)
                .HasDefaultValueSql("gen_random_uuid()")
                .HasColumnName("id");
            entity.Property(e => e.AnkiGuid)
                .HasColumnType("character varying")
                .HasColumnName("anki_guid");
            entity.Property(e => e.ArticleId).HasColumnName("article_id");
            entity.Property(e => e.Back).HasColumnName("back");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("timestamp(6) without time zone")
                .HasColumnName("created_at");
            entity.Property(e => e.Front).HasColumnName("front");
            entity.Property(e => e.OrdinalPosition).HasColumnName("ordinal_position");
            entity.Property(e => e.UpdatedAt)
                .HasColumnType("timestamp(6) without time zone")
                .HasColumnName("updated_at");

            entity.HasOne(d => d.Article).WithMany(p => p.BasicNotes)
                .HasForeignKey(d => d.ArticleId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_rails_ffcee13409");
        });

        modelBuilder.Entity<Book>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("books_pkey");

            entity.ToTable("books");

            entity.Property(e => e.Id)
                .HasDefaultValueSql("gen_random_uuid()")
                .HasColumnName("id");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("timestamp(6) without time zone")
                .HasColumnName("created_at");
            entity.Property(e => e.ParentBookId).HasColumnName("parent_book_id");
            entity.Property(e => e.Public).HasColumnName("public");
            entity.Property(e => e.Title)
                .HasColumnType("character varying")
                .HasColumnName("title");
            entity.Property(e => e.UpdatedAt)
                .HasColumnType("timestamp(6) without time zone")
                .HasColumnName("updated_at");

            entity.HasOne(d => d.ParentBook).WithMany(p => p.InverseParentBook)
                .HasForeignKey(d => d.ParentBookId)
                .HasConstraintName("fk_rails_c56e8bfbcd");
        });

        modelBuilder.Entity<BooksUser>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("books_users_pkey");

            entity.ToTable("books_users");

            entity.HasIndex(e => new { e.BookId, e.UserId }, "index_books_users_on_book_id_and_user_id").IsUnique();

            entity.Property(e => e.Id)
                .HasDefaultValueSql("gen_random_uuid()")
                .HasColumnName("id");
            entity.Property(e => e.BookId).HasColumnName("book_id");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("timestamp(6) without time zone")
                .HasColumnName("created_at");
            entity.Property(e => e.UpdatedAt)
                .HasColumnType("timestamp(6) without time zone")
                .HasColumnName("updated_at");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.Book).WithMany(p => p.BooksUsers)
                .HasForeignKey(d => d.BookId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_rails_075a74cf57");

            entity.HasOne(d => d.User).WithMany(p => p.BooksUsers)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_rails_8be04227a5");
        });

        modelBuilder.Entity<ClozeNote>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("cloze_notes_pkey");

            entity.ToTable("cloze_notes");

            entity.HasIndex(e => e.AnkiGuid, "index_cloze_notes_on_anki_guid").IsUnique();

            entity.HasIndex(e => e.ArticleId, "index_cloze_notes_on_article_id");

            entity.Property(e => e.Id)
                .HasDefaultValueSql("gen_random_uuid()")
                .HasColumnName("id");
            entity.Property(e => e.AnkiGuid)
                .HasColumnType("character varying")
                .HasColumnName("anki_guid");
            entity.Property(e => e.ArticleId).HasColumnName("article_id");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("timestamp(6) without time zone")
                .HasColumnName("created_at");
            entity.Property(e => e.Sentence).HasColumnName("sentence");
            entity.Property(e => e.UpdatedAt)
                .HasColumnType("timestamp(6) without time zone")
                .HasColumnName("updated_at");

            entity.HasOne(d => d.Article).WithMany(p => p.ClozeNotes)
                .HasForeignKey(d => d.ArticleId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_rails_8740326664");
        });

        modelBuilder.Entity<ClozeNotesConcept>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("cloze_notes_concepts_pkey");

            entity.ToTable("cloze_notes_concepts");

            entity.HasIndex(e => new { e.ClozeNoteId, e.ConceptId }, "index_cloze_notes_concepts_on_cloze_note_id_and_concept_id").IsUnique();

            entity.Property(e => e.Id)
                .HasDefaultValueSql("gen_random_uuid()")
                .HasColumnName("id");
            entity.Property(e => e.ClozeNoteId).HasColumnName("cloze_note_id");
            entity.Property(e => e.ConceptId).HasColumnName("concept_id");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("timestamp(6) without time zone")
                .HasColumnName("created_at");
            entity.Property(e => e.UpdatedAt)
                .HasColumnType("timestamp(6) without time zone")
                .HasColumnName("updated_at");

            entity.HasOne(d => d.ClozeNote).WithMany(p => p.ClozeNotesConcepts)
                .HasForeignKey(d => d.ClozeNoteId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_rails_baf7b78896");

            entity.HasOne(d => d.Concept).WithMany(p => p.ClozeNotesConcepts)
                .HasForeignKey(d => d.ConceptId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_rails_78796f9fb0");
        });

        modelBuilder.Entity<Concept>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("concepts_pkey");

            entity.ToTable("concepts");

            entity.HasIndex(e => new { e.UserId, e.Name }, "index_concepts_on_user_id_and_name").IsUnique();

            entity.Property(e => e.Id)
                .HasDefaultValueSql("gen_random_uuid()")
                .HasColumnName("id");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("timestamp(6) without time zone")
                .HasColumnName("created_at");
            entity.Property(e => e.Name)
                .HasColumnType("character varying")
                .HasColumnName("name");
            entity.Property(e => e.UpdatedAt)
                .HasColumnType("timestamp(6) without time zone")
                .HasColumnName("updated_at");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.User).WithMany(p => p.Concepts)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_rails_b0e69cca70");
        });

        modelBuilder.Entity<SchemaMigration>(entity =>
        {
            entity.HasKey(e => e.Version).HasName("schema_migrations_pkey");

            entity.ToTable("schema_migrations");

            entity.Property(e => e.Version)
                .HasColumnType("character varying")
                .HasColumnName("version");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("users_pkey");

            entity.ToTable("users");

            entity.HasIndex(e => e.Email, "index_users_on_email").IsUnique();

            entity.HasIndex(e => e.Username, "index_users_on_username").IsUnique();

            entity.Property(e => e.Id)
                .HasDefaultValueSql("gen_random_uuid()")
                .HasColumnName("id");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("timestamp(6) without time zone")
                .HasColumnName("created_at");
            entity.Property(e => e.Email)
                .HasColumnType("character varying")
                .HasColumnName("email");
            entity.Property(e => e.PasswordDigest)
                .HasColumnType("character varying")
                .HasColumnName("password_digest");
            entity.Property(e => e.UpdatedAt)
                .HasColumnType("timestamp(6) without time zone")
                .HasColumnName("updated_at");
            entity.Property(e => e.Username)
                .HasColumnType("character varying")
                .HasColumnName("username");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}

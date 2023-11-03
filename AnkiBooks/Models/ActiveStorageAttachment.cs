using System;
using System.Collections.Generic;

namespace AnkiBooks.Models;

public partial class ActiveStorageAttachment
{
    public Guid Id { get; set; }

    public string Name { get; set; } = null!;

    public string RecordType { get; set; } = null!;

    public DateTime CreatedAt { get; set; }

    public Guid RecordId { get; set; }

    public Guid BlobId { get; set; }

    public virtual ActiveStorageBlob Blob { get; set; } = null!;
}

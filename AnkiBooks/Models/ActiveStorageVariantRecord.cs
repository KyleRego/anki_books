using System;
using System.Collections.Generic;

namespace AnkiBooks.Models;

public partial class ActiveStorageVariantRecord
{
    public Guid Id { get; set; }

    public string VariationDigest { get; set; } = null!;

    public Guid BlobId { get; set; }

    public virtual ActiveStorageBlob Blob { get; set; } = null!;
}

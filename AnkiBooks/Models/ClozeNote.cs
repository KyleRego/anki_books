using System;
using System.Collections.Generic;

namespace AnkiBooks.Models;

public partial class ClozeNote
{
    public Guid Id { get; set; }

    public string Sentence { get; set; } = null!;

    public Guid ArticleId { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime UpdatedAt { get; set; }

    public string AnkiGuid { get; set; } = null!;

    public virtual Article Article { get; set; } = null!;

    public virtual ICollection<ClozeNotesConcept> ClozeNotesConcepts { get; set; } = new List<ClozeNotesConcept>();
}

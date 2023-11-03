using System;
using System.Collections.Generic;

namespace AnkiBooks.Models;

public partial class ClozeNotesConcept
{
    public Guid Id { get; set; }

    public Guid ClozeNoteId { get; set; }

    public Guid ConceptId { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime UpdatedAt { get; set; }

    public virtual ClozeNote ClozeNote { get; set; } = null!;

    public virtual Concept Concept { get; set; } = null!;
}

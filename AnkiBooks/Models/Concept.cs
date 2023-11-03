using System;
using System.Collections.Generic;

namespace AnkiBooks.Models;

public partial class Concept
{
    public Guid Id { get; set; }

    public string Name { get; set; } = null!;

    public DateTime CreatedAt { get; set; }

    public DateTime UpdatedAt { get; set; }

    public Guid UserId { get; set; }

    public virtual ICollection<ClozeNotesConcept> ClozeNotesConcepts { get; set; } = new List<ClozeNotesConcept>();

    public virtual User User { get; set; } = null!;
}

﻿using System;
using System.Collections.Generic;

namespace AnkiBooks.Models;

public partial class BasicNote
{
    public Guid Id { get; set; }

    public string? Front { get; set; }

    public string? Back { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime UpdatedAt { get; set; }

    public Guid ArticleId { get; set; }

    public int OrdinalPosition { get; set; }

    public string AnkiGuid { get; set; } = null!;

    public virtual Article Article { get; set; } = null!;
}
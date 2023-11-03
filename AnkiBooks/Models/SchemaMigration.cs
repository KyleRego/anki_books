using System;
using System.Collections.Generic;

namespace AnkiBooks.Models;

public partial class SchemaMigration
{
    public string Version { get; set; } = null!;
}

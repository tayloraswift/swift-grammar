extension UnicodeEncoding where Terminal:ASCIITerminal 
{
    /// Parses a newline; either a ``Linefeed`` or a ``CarriageReturn`` followed by a 
    /// ``Linefeed``.
    public 
    enum Newline:ParsingRule 
    {
        @inlinable public static 
        func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) throws 
            where   Diagnostics:ParsingDiagnostics,
                    Diagnostics.Source.Index == Location,
                    Diagnostics.Source.Element == Terminal
        {
            if case nil = input.parse(as: Linefeed?.self) 
            {
                try input.parse(as: (CarriageReturn, Linefeed).self)
            }
        }
    }
}

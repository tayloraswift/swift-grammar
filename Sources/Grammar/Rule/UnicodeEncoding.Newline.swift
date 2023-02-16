extension UnicodeEncoding where Terminal:ASCIITerminal 
{
    /// Parses a newline; either a ``Linefeed`` or a ``CarriageReturn`` followed by a 
    /// ``Linefeed``.
    public 
    enum Newline:ParsingRule 
    {
        @inlinable public static 
        func parse<Source>(_ input:inout ParsingInput<some ParsingDiagnostics<Source>>) throws
            where Source:Collection<Terminal>, Source.Index == Location
        {
            if case nil = input.parse(as: Linefeed?.self) 
            {
                try input.parse(as: (CarriageReturn, Linefeed).self)
            }
        }
    }
}

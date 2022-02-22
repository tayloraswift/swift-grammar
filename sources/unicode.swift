extension Grammar.Encoding where Terminal == Unicode.Scalar
{
    public 
    enum Newline:ParsingRule 
    {
        public 
        typealias Terminal = Unicode.Scalar
        @inlinable public static 
        func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) throws 
            where   Diagnostics:ParsingDiagnostics,
                    Diagnostics.Source.Index == Location,
                    Diagnostics.Source.Element == Terminal
        {
            if let _:Void = input.parse(as: Linefeed?.self) 
            {
            }
            else 
            {
                try input.parse(as: (Return, Linefeed).self)
            }
        }
    }
    
    public 
    enum E 
    {
        public 
        enum Anycase:Grammar.TerminalClass 
        {
            public 
            typealias Construction  = Void
            @inlinable public static 
            func parse(terminal:Unicode.Scalar) -> Void?
            {
                switch terminal 
                {
                case "e", "E":  return ()
                default:        return nil
                }
            }
        }
    }
    
    public
    enum AngleLeft:Grammar.TerminalSequence
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("<") }
    }
    public
    enum AngleRight:Grammar.TerminalSequence
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init(">") }
    }
    
    public
    enum Backslash:Grammar.TerminalSequence
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("\\") }
    }
    public
    enum BracketLeft:Grammar.TerminalSequence
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("[") }
    }
    public
    enum BracketRight:Grammar.TerminalSequence
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("]") }
    }
    
    public
    enum And:Grammar.TerminalSequence
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("&") }
    }
    public
    enum BraceLeft:Grammar.TerminalSequence
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("{") }
    }
    public
    enum BraceRight:Grammar.TerminalSequence
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("}") }
    }
    
    public
    enum Colon:Grammar.TerminalSequence
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init(":") }
    }
    public
    enum Comma:Grammar.TerminalSequence
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init(",") }
    }
    public
    enum Dollar:Grammar.TerminalSequence
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("$") }
    }
    public
    enum Equals:Grammar.TerminalSequence
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("=") }
    }
    public
    enum Linefeed:Grammar.TerminalSequence
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("\n") }
    }
    public
    enum Minus:Grammar.TerminalSequence
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("-") }
    }
    
    public
    enum ParenthesisLeft:Grammar.TerminalSequence
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("(") }
    }
    public
    enum ParenthesisRight:Grammar.TerminalSequence
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init(")") }
    }
    
    public
    enum Percent:Grammar.TerminalSequence
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("%") }
    }
    public
    enum Period:Grammar.TerminalSequence
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init(".") }
    }
    public
    enum Plus:Grammar.TerminalSequence
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("+") }
    }
    public
    enum Quote:Grammar.TerminalSequence
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("\"") }
    }
    enum Question:Grammar.TerminalSequence 
    {
        static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("?") }
    }
    public
    enum Return:Grammar.TerminalSequence
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("\r") }
    }
    public
    enum Slash:Grammar.TerminalSequence
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("/") }
    }
    public
    enum Zero:Grammar.TerminalSequence
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("0") }
    }
    public 
    typealias Hyphen = Minus
    public 
    enum X
    {
        public
        enum Lowercase:Grammar.TerminalSequence 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Unicode.Scalar> { .init("x") }
        }
    }
    public 
    enum U
    {
        public
        enum Lowercase:Grammar.TerminalSequence 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Unicode.Scalar> { .init("u") }
        }
    }
    public 
    enum Whitespace:Grammar.TerminalClass 
    {
        public 
        typealias Construction  = Void
        @inlinable public static 
        func parse(terminal:Unicode.Scalar) -> Void?
        {
            terminal.properties.isWhitespace ? () : nil
        }
    }
}
extension Grammar.Digit where Terminal == Unicode.Scalar
{
    public 
    enum Decimal:Grammar.DigitRule, Grammar.TerminalClass 
    {
        @inlinable public static 
        var radix:Construction 
        {
            10
        }
        @inlinable public static 
        func parse(terminal:Terminal) -> Construction?
        {
            switch terminal 
            {
            case "0":   return 0
            case "1":   return 1
            case "2":   return 2
            case "3":   return 3
            case "4":   return 4
            case "5":   return 5
            case "6":   return 6
            case "7":   return 7
            case "8":   return 8
            case "9":   return 9
            default:    return nil
            }
        }
    }
    public 
    enum Hex 
    {
        public 
        enum Lowercase:Grammar.DigitRule 
        {
            @inlinable public static 
            var radix:Construction 
            {
                16
            }
            @inlinable public static 
            func parse(terminal:Unicode.Scalar) -> Construction?
            {
                switch terminal 
                {
                case "0" ... "9":
                    return Construction.init(terminal.value      - ("0" as Unicode.Scalar).value)
                case "a" ... "f":
                    return Construction.init(terminal.value + 10 - ("a" as Unicode.Scalar).value)
                default:
                    return nil
                }
            }
        }
        public 
        enum Anycase:Grammar.DigitRule 
        {
            @inlinable public static 
            var radix:Construction 
            {
                16
            }
            @inlinable public static 
            func parse(terminal:Unicode.Scalar) -> Construction?
            {
                switch terminal 
                {
                case "0" ... "9":
                    return Construction.init(terminal.value      - ("0" as Unicode.Scalar).value)
                case "a" ... "f":
                    return Construction.init(terminal.value + 10 - ("a" as Unicode.Scalar).value)
                case "A" ... "F":
                    return Construction.init(terminal.value + 10 - ("A" as Unicode.Scalar).value)
                default:
                    return nil
                }
            }
        }
    }
}

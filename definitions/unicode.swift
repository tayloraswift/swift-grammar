extension Grammar.Encoding where Terminal == Unicode.Scalar
{
    /* enum Letter:Grammar.TerminalClass 
    {
        typealias Construction  = Unicode.Scalar 
        static 
        func parse(terminal:Unicode.Scalar) -> Unicode.Scalar?
        {
            terminal.properties.isLetter ? terminal : nil
        }
    } */
    
    enum Newline:ParsingRule 
    {
        typealias Terminal = Unicode.Scalar
        static 
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
    
    enum E 
    {
        enum Anycase:Grammar.TerminalClass 
        {
            typealias Construction  = Void
            static 
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
    
    enum AngleLeft:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("<") }
    }
    enum AngleRight:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init(">") }
    }
    
    enum Backslash:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("\\") }
    }
    enum BracketLeft:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("[") }
    }
    enum BracketRight:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("]") }
    }
    
    enum And:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("&") }
    }
    enum BraceLeft:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("{") }
    }
    enum BraceRight:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("}") }
    }
    
    enum Colon:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init(":") }
    }
    enum Comma:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init(",") }
    }
    enum Dollar:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("$") }
    }
    enum Linefeed:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("\n") }
    }
    enum Minus:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("-") }
    }
    
    enum ParenthesisLeft:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("(") }
    }
    enum ParenthesisRight:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init(")") }
    }
    
    enum Percent:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("%") }
    }
    enum Period:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init(".") }
    }
    enum Plus:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("+") }
    }
    enum Quote:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("\"") }
    }
    enum Return:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("\r") }
    }
    enum Slash:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("/") }
    }
    enum Zero:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("0") }
    }
    
    typealias Hyphen = Minus
    
    enum X
    {
        enum Lowercase:Grammar.TerminalSequence 
        {
            static 
            var literal:CollectionOfOne<Unicode.Scalar> { .init("x") }
        }
    }
    enum U
    {
        enum Lowercase:Grammar.TerminalSequence 
        {
            static 
            var literal:CollectionOfOne<Unicode.Scalar> { .init("u") }
        }
    }
    
    enum Whitespace:Grammar.TerminalClass 
    {
        typealias Construction  = Void
        static 
        func parse(terminal:Unicode.Scalar) -> Void?
        {
            terminal.properties.isWhitespace ? () : nil
        }
    }
}
extension Grammar.Digit where Terminal == Unicode.Scalar
{
    enum Decimal:Grammar.DigitRule, Grammar.TerminalClass 
    {
        static 
        var radix:Construction 
        {
            10
        }
        static 
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
    enum Hex 
    {
        /* private static 
        subscript(lowercasing value:Int) -> Unicode.Scalar 
        {
            let remainder:UInt8 = .init(value)
            return Unicode.Scalar.init(Unicode.Scalar.init((remainder < 10 ? 0x30 : 0x57) &+ remainder))
        } */
        enum Lowercase:Grammar.DigitRule 
        {
            static 
            var radix:Construction 
            {
                16
            }
            static 
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
        enum Anycase:Grammar.DigitRule 
        {
            // typealias Terminal = Unicode.Scalar
            static 
            var radix:Construction 
            {
                16
            }
            static 
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

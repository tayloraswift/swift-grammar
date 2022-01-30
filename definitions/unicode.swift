extension Character 
{
    enum Letter<Location>:Grammar.TerminalClass 
    {
        typealias Terminal      = Character 
        typealias Construction  = Character 
        static 
        func parse(terminal character:Character) -> Character?
        {
            character.isLetter ? character : nil
        }
    }
    
    enum E 
    {
        enum Anycase<Location>:Grammar.TerminalClass 
        {
            typealias Terminal      = Character 
            typealias Construction  = Void
            static 
            func parse(terminal character:Character) -> Void?
            {
                switch character 
                {
                case "e", "E":  return ()
                default:        return nil
                }
            }
        }
    }
    
    enum AngleLeft<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = Character
        static 
        var literal:CollectionOfOne<Character> { .init("<") }
    }
    enum AngleRight<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = Character 
        static 
        var literal:CollectionOfOne<Character> { .init(">") }
    }
    
    enum Backslash<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = Character 
        static 
        var literal:CollectionOfOne<Character> { .init("\\") }
    }
    enum BracketLeft<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = Character 
        static 
        var literal:CollectionOfOne<Character> { .init("[") }
    }
    enum BracketRight<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = Character 
        static 
        var literal:CollectionOfOne<Character> { .init("]") }
    }
    /* struct Bracketed<Expression>:Grammar.BracketedExpression 
        where Expression:Grammar.Parsable, Expression.Terminal == Character
    {
        typealias Terminal  = Character
        typealias Start     = BracketLeft  
        typealias End       = BracketRight
        
        let production:Expression.Production
    } */
    
    enum And<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = Character 
        static 
        var literal:CollectionOfOne<Character> { .init("&") }
    }
    enum BraceLeft<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = Character 
        static 
        var literal:CollectionOfOne<Character> { .init("{") }
    }
    enum BraceRight<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = Character 
        static 
        var literal:CollectionOfOne<Character> { .init("}") }
    }
    /* struct Braced<Expression>:Grammar.BracketedExpression 
        where Expression:Grammar.Parsable, Expression.Terminal == Character
    {
        typealias Terminal  = Character
        typealias Start     = BraceLeft  
        typealias End       = BraceRight
        
        let production:Expression.Production
    } */
    
    enum Colon<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = Character 
        static 
        var literal:CollectionOfOne<Character> { .init(":") }
    }
    enum Comma<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = Character 
        static 
        var literal:CollectionOfOne<Character> { .init(",") }
    }
    enum Minus<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = Character 
        static 
        var literal:CollectionOfOne<Character> { .init("-") }
    }
    
    enum ParenthesisLeft<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = Character 
        static 
        var literal:CollectionOfOne<Character> { .init("(") }
    }
    enum ParenthesisRight<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = Character 
        static 
        var literal:CollectionOfOne<Character> { .init(")") }
    }
    /* struct Parenthesized<Expression>:Grammar.BracketedExpression 
        where Expression:Grammar.Parsable, Expression.Terminal == Character
    {
        typealias Terminal  = Character
        typealias Start     = ParenthesisLeft 
        typealias End       = ParenthesisRight
        
        let production:Expression.Production
    } */
    
    enum Percent<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = Character 
        static 
        var literal:CollectionOfOne<Character> { .init("%") }
    }
    enum Period<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = Character 
        static 
        var literal:CollectionOfOne<Character> { .init(".") }
    }
    enum Plus<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = Character 
        static 
        var literal:CollectionOfOne<Character> { .init("+") }
    }
    enum Quote<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = Character 
        static 
        var literal:CollectionOfOne<Character> { .init("\"") }
    }
    enum Slash<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = Character 
        static 
        var literal:CollectionOfOne<Character> { .init("/") }
    }
    enum Zero<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = Character 
        static 
        var literal:CollectionOfOne<Character> { .init("0") }
    }
    
    typealias Hyphen = Minus
    
    enum U
    {
        enum Lowercase<Location>:Grammar.TerminalSequence 
        {
            typealias Terminal = Character 
            static 
            var literal:CollectionOfOne<Character> { .init("u") }
        }
    }
    
    
    enum Whitespace<Location>:Grammar.TerminalClass 
    {
        typealias Terminal      = Character 
        typealias Construction  = Void
        static 
        func parse(terminal character:Character) -> Void?
        {
            character.isWhitespace ? () : nil
        }
    }
    enum DecimalDigit<Location, Construction>:Grammar.Digit 
        where Construction:BinaryInteger
    {
        typealias Terminal = Character 
        static 
        var radix:Construction 
        {
            10
        }
        static 
        func parse(terminal character:Character) -> Construction?
        {
            switch character 
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
    enum HexDigit 
    {
        /* private static 
        subscript(lowercasing value:Int) -> Character 
        {
            let remainder:UInt8 = .init(value)
            return Character.init(Unicode.Scalar.init((remainder < 10 ? 0x30 : 0x57) &+ remainder))
        } */
        enum Lowercase<Location, Construction>:Grammar.Digit
            where Construction:BinaryInteger
        {
            typealias Terminal = Character
            static 
            var radix:Construction 
            {
                16
            }
            static 
            func parse(terminal character:Character) -> Construction?
            {
                // 0-9 will return false for isLowercase
                character.isUppercase ? nil : character.hexDigitValue.map(Construction.init(_:))
            }
        }
        enum Anycase<Location, Construction>:Grammar.Digit
            where Construction:BinaryInteger
        {
            typealias Terminal = Character
            static 
            var radix:Construction 
            {
                16
            }
            static 
            func parse(terminal character:Character) -> Construction?
            {
                character.hexDigitValue.map(Construction.init(_:))
            }
        }
    }
}

extension Unicode.ASCII 
{
    enum StartOfHeader<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = UInt8
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x01) }
    }
    
    enum Colon<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = UInt8
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x3a) }
    }
    enum Equals<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = UInt8
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x3d) }
    }
    enum Minus<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = UInt8
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x2d) }
    }
    enum Period<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = UInt8
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x2e) }
    }
    enum Quote<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = UInt8
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x22) }
    }
    enum Space<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = UInt8
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x20) }
    }
    
    enum Zero<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = UInt8
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x30) }
    }
    enum One<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = UInt8
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x31) }
    }
    enum Two<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = UInt8
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x32) }
    }
    enum Three<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = UInt8
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x33) }
    }
    enum Four<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = UInt8
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x34) }
    }
    enum Five<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = UInt8
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x35) }
    }
    enum Six<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = UInt8
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x36) }
    }
    enum Seven<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = UInt8
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x37) }
    }
    enum Eight<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = UInt8
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x38) }
    }
    enum Nine<Location>:Grammar.TerminalSequence
    {
        typealias Terminal = UInt8
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x39) }
    }
    
    typealias Hyphen = Minus
    
    enum DecimalDigit<Location, Construction>:Grammar.Digit 
        where Construction:BinaryInteger
    {
        typealias Terminal = UInt8
        static 
        var radix:Construction 
        {
            10
        }
        static 
        func parse(terminal codepoint:UInt8) -> Construction? 
        {
            guard 0x30 ... 0x39 ~= codepoint 
            else 
            {
                return nil 
            }
            return .init(codepoint - 0x30)
        }
    }
}

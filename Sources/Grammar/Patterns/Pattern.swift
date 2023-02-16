/// A namespace for structured parsing utilities.
public 
enum Pattern 
{
    /// A rule that expects the end of the input. 
    /// 
    /// >   Throws: ``UnexpectedValueError`` if there is any 
    ///     input remaining.
    public
    enum End<Location, Terminal>:ParsingRule 
    {
        @inlinable public static 
        func parse<Source>(_ input:inout ParsingInput<some ParsingDiagnostics<Source>>) throws 
            where Source:Collection<Terminal>, Source.Index == Location
        {
            if let _:Terminal = input.next() 
            {
                throw UnexpectedValueError.init()
            }
        }
    }
    /// A rule that unconditionally ignores all remaining input.
    /// 
    /// This rule never throws an error.
    public 
    enum Discard<Rule>:ParsingRule 
        where Rule:ParsingRule, Rule.Construction == Void
    {
        public 
        typealias Location = Rule.Location
        public 
        typealias Terminal = Rule.Terminal 
        @inlinable public static 
        func parse<Source>(_ input:inout ParsingInput<some ParsingDiagnostics<Source>>) 
            where Source:Collection<Terminal>, Source.Index == Location
        {
            input.parse(as: Rule.self, in: Void.self)
        }
    }
    public 
    enum Collect<Rule, Construction>:ParsingRule 
        where Rule:ParsingRule, Construction:RangeReplaceableCollection<Rule.Construction>
    {
        public 
        typealias Location = Rule.Location
        public 
        typealias Terminal = Rule.Terminal

        @inlinable public static 
        func parse<Source>(
            _ input:inout ParsingInput<some ParsingDiagnostics<Source>>) -> Construction
            where Source:Collection<Terminal>, Source.Index == Location
        {
            input.parse(as: Rule.self, in: Construction.self)
        }
    }
    public 
    enum Reduce<Rule, Construction>:ParsingRule 
        where Rule:ParsingRule, Construction:RangeReplaceableCollection<Rule.Construction>
    {
        public 
        typealias Location = Rule.Location
        public 
        typealias Terminal = Rule.Terminal

        @inlinable public static 
        func parse<Source>(
            _ input:inout ParsingInput<some ParsingDiagnostics<Source>>) throws -> Construction
            where Source:Collection<Terminal>, Source.Index == Location
        {
            var vector:Construction = .init()
                vector.append(try input.parse(as: Rule.self))
            while let next:Rule.Construction = input.parse(as: Rule?.self)
            {
                vector.append(next)
            }
            return vector
        }
    }
    public 
    enum Join<Rule, Separator, Construction>:ParsingRule
        where   Rule:ParsingRule,
                Separator:ParsingRule<Rule.Terminal>,
                Separator.Location == Rule.Location,
                Separator.Construction == Void, 
                Construction:RangeReplaceableCollection<Rule.Construction>
    {
        public 
        typealias Terminal = Rule.Terminal
        public 
        typealias Location = Rule.Location

        @inlinable public static 
        func parse<Source>(
            _ input:inout ParsingInput<some ParsingDiagnostics<Source>>) throws -> Construction
            where Source:Collection<Terminal>, Source.Index == Location
        {
            var vector:Construction = .init()
                vector.append(try input.parse(as: Rule.self))
            while   let (_, next):(Void, Rule.Construction) =
                    try? input.parse(as: (Separator, Rule).self)
            {
                vector.append(next)
            }
            return vector
        }
    }
    public 
    enum Pad<Rule, Padding>:ParsingRule
        where   Rule:ParsingRule,
                Padding:ParsingRule<Rule.Terminal>, 
                Padding.Location == Rule.Location,
                Padding.Construction == Void
    {
        public 
        typealias Terminal = Rule.Terminal
        public 
        typealias Location = Rule.Location

        @inlinable public static 
        func parse<Source>(
            _ input:inout ParsingInput<some ParsingDiagnostics<Source>>) throws -> Rule.Construction
            where Source:Collection<Terminal>, Source.Index == Location
        {
            input.parse(as: Padding.self, in: Void.self)
            let construction:Rule.Construction = try input.parse(as: Rule.self) 
            input.parse(as: Padding.self, in: Void.self)
            return construction
        }
    }

    public
    typealias UnsignedInteger<Digit> = UnsignedNormalizedInteger<Digit, Digit>
        where Digit:DigitRule, Digit.Construction:FixedWidthInteger
    
    public
    enum UnsignedNormalizedInteger<First, Next>:ParsingRule
    where   First:ParsingRule, First.Construction:FixedWidthInteger,
            Next:DigitRule<First.Terminal, First.Construction>,
            Next.Location == First.Location
    {
        public
        typealias Location = First.Location
        public
        typealias Terminal = First.Terminal
        
        @inlinable public static 
        func parse<Source>(
            _ input:inout ParsingInput<some ParsingDiagnostics<Source>>) throws -> Next.Construction
            where Source:Collection<Terminal>, Source.Index == Location
        {
            var value:Next.Construction = try input.parse(as: First.self)
            while let remainder:Next.Construction = input.parse(as: Next?.self)
            {
                guard   case (let shifted, false) = value.multipliedReportingOverflow(by: Next.radix), 
                        case (let refined, false) = shifted.addingReportingOverflow(remainder)
                else 
                {
                    throw IntegerOverflowError<Next.Construction>.init()
                }
                value = refined
            }
            return value
        }
    }
}
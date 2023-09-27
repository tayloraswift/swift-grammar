import TraceableErrors

/// An error type that indicates the furthest-successful parse, and provides a
/// stack trace detailing how the parser got there.
///
/// None of the structured parsers defined in swift-grammar throw this error
/// directly. Instead, the ``DefaultDiagnostics`` engine computes it
/// based on the diagnostic engine’s internal state when encountering
/// invalid input.
///
/// Custom ``ParsingRule`` implementations should not throw this error either.
@frozen public
struct ParsingError<Index>:TraceableError, CustomStringConvertible
{
    /// The underlying parsing error.
    public
    let underlying:Error
    /// The index of the first invalid terminal in the input, or the ``Collection endIndex``
    /// of the input.
    ///
    /// If the parser attempted to apply multiple rules via backtracking, this
    /// index comes from the longest successful parse.
    public
    let index:Index
    public
    let trace:[Frame]

    @inlinable public
    init(at index:Index, because error:Error, trace:[Frame])
    {
        self.underlying = error
        self.index      = index
        self.trace      = trace
    }

    public
    var notes:[String]
    {
        trace.map
        {
            if $0.construction is Void.Type
            {
                return "while matching pattern '\($0.rule)'"
            }
            else
            {
                return "while parsing value of type '\($0.construction)' by rule '\($0.rule)'"
            }
        }
    }

    static
    func annotate<Background>(_ range:Range<Index>, background:Background,
        renderer render:(Background.SubSequence) -> String,
        newline predicate:(Background.Element) -> Bool)
        -> String
        where Background:BidirectionalCollection, Background.Index == Index
    {
        // `..<` means this will print the previous line if the problematic
        // index references the newline itself
        let beginning:String,
            middle:String
        if let start:Index  = background[..<range.lowerBound].lastIndex (where: predicate)
        {
            // can only remove newline if there is actually a preceeding newline
            beginning = render(background[start..<range.lowerBound].dropFirst())
        }
        else
        {
            beginning = render(background[..<range.lowerBound])
        }
        let line:String
        let   end:Index     = background[range.lowerBound...].firstIndex(where: predicate) ??
            background.endIndex
        if range.upperBound < end
        {
            middle  = render(background[range])
            line    = beginning + middle + render(background[range.upperBound..<end])
        }
        else
        {
            middle  = render(background[range.lowerBound..<end])
            line    = beginning + middle
        }
        return
            """
            \(line)
            \(String.init(repeating: " ", count: beginning.count))\
            ^\(String.init(repeating: "~", count: middle.count).dropLast())
            """
    }
    public
    func annotate<Background>(source background:Background,
        renderer:(Background.SubSequence) -> String,
        newline:(Background.Element) -> Bool) -> String
        where Background:BidirectionalCollection, Background.Index == Index
    {
        var annotation:String = self.underlying.headline()

        annotation.append("\n")
        annotation += Self.annotate(background.index(before: self.index) ..< self.index,
            background: background,
            renderer: renderer,
            newline: newline)
        for frame:Frame in self.trace.reversed()
        {
            annotation +=
            """

            note: while parsing pattern '\(frame.rule)'
            \(Self.annotate(frame.index ..< self.index,
                background: background,
                renderer: renderer,
                newline: newline))
            """
        }
        return annotation
    }
}

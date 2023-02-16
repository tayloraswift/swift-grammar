/// A performance-optimized diagnostic engine that maintains minimal internal 
/// state, and emits no diagnostics.
/// 
/// Parsing with ``NoDiagnostics`` is efficient, but does not provide 
/// useful debugging information. The errors it emits may have little to do 
/// with the intuitive reason why parsing failed.
/// 
/// For richer debugging information, use ``DefaultDiagnostics`` instead.
@frozen public 
struct NoDiagnostics<Source>:ParsingDiagnostics where Source:Collection
{
    @inlinable public 
    init() 
    {
    }
    // force inlining because these functions ignore most of their inputs, and 
    // don’t contain many instructions (if any)
    @inline(__always)
    @inlinable public 
    func push(index:Source.Index, for _:(some Any).Type, by _:(some Any).Type) -> Source.Index
    {
        index
    }
    @inline(__always)
    @inlinable public 
    func pop()
    {
    }
    @inline(__always)
    @inlinable public 
    func reset(index:inout Source.Index, to breadcrumb:Source.Index, because _:inout any Error) 
    {
        index = breadcrumb 
    }
}

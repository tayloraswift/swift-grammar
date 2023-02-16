#if swift(>=5.7)
/// An abstract interface used by ``ParsingInput`` to emit (or not emit) debugging 
/// information to.
public
protocol ParsingDiagnostics<Source> 
{
    associatedtype Source where Source:Collection 
    associatedtype Breadcrumb 
    
    init()
    
    mutating 
    func push<Rule, Construction>(index:Source.Index, for _:Construction.Type,
        by _:Rule.Type) -> Breadcrumb
    mutating 
    func pop()
    mutating 
    func reset(index:inout Source.Index, to:Breadcrumb, because:inout any Error) 
}
#else 
/// An abstract interface used by ``ParsingInput`` to emit (or not emit) debugging 
/// information to.
public
protocol ParsingDiagnostics
{
    associatedtype Source where Source:Collection 
    associatedtype Breadcrumb 
    
    init()
    
    mutating 
    func push<Rule, Construction>(index:Source.Index, for _:Construction.Type, by _:Rule.Type) 
        -> Breadcrumb
    mutating 
    func pop()
    mutating 
    func reset(index:inout Source.Index, to:Breadcrumb, because:inout Error) 
}
#endif 

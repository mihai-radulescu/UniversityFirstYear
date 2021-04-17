#ifndef STATE_H_INCLUDED
#define STATE_H_INCLUDED

namespace edy
{
namespace core
{
class PointerPack;
class State
{
public:
    virtual void run(PointerPack& pack)=0;
    virtual ~State() {}
};
}
}

#endif // STATE_H_INCLUDED

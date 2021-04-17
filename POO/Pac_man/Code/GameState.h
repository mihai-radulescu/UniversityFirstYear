#ifndef GAMESTATE_H_INCLUDED
#define GAMESTATE_H_INCLUDED

#include "State.h"
#include "Engine.h"

#include <SFML/Graphics/RenderTexture.hpp>
#include <SFML/Graphics/Sprite.hpp>
#include <SFML/System/Clock.hpp>
#include <SFML/Graphics/Text.hpp>

namespace edy
{
namespace core
{
class PointerPack;
}
namespace state
{
class GameState : public core::State
{
public:
    GameState();
    virtual void run(core::PointerPack& pack);
    bool loadMap();

private:

    void drawAll();
    void drawCherry(int x,int y);
    void drawBooster(int x,int y);
    void drawPill(int x,int y);
    void drawGhosts();

    sf::Text lives,score;
    bool mapOk;
    sf::Texture mAtlas;
    sf::Sprite guys[5],leftEye,rightEye;
    core::PointerPack * mPack;
    int currentMap,mScore,pacframe;
    std::string mMapNames[3];
    pac::PacEngine mEngine;
    sf::Clock mAnimClock;
};
}
}

#endif // GAMESTATE_H_INCLUDED

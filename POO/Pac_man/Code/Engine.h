#ifndef ENGINE_H_INCLUDED
#define ENGINE_H_INCLUDED

#include "Entity.h"
#include "Event.h"

#include <SFML/System/Vector2.hpp>
#include <string>
#include <deque>

namespace sf
{
class RenderTarget;
}
namespace edy
{
namespace pac
{

enum eEntsID {Pac=0,Blinky=1,Inky=2,Pinky=3,Clyde=4};

class PacEngine
{
public:
    enum TileType
    {
        Cherry=0,
        Pill=1,
        Booster=2,
        Wall=3,
        Tunnel=7,
        Empty=8,
        GhostSpawn=9
    };
    enum ScareStatus {Brave,Scared,Blinking,Dead};
    PacEngine();
    sf::Vector2f getPosition(int who);
    float getRotation(int who);
    bool loadMap(const std::string& path);
    void update();
    bool getEvent(PacEvent& event);
    void setPacDirection(PacEntity::eDirection direction);
    void makeWallsMap(sf::RenderTarget& target);

    unsigned char mMap[28][31];
    ScareStatus getScareStatus(int who)const;
private:

    void updatePac();
    void checkCollisions();
    void resetPositions();
    void checkPills();
    void updateGhost(int who);
    int fetchTileAt(sf::Vector2i pos,sf::Vector2i off);
    PacEntity::eDirection getNextMove(sf::Vector2f pos,sf::Vector2i targ,PacEntity::eDirection cur);
    sf::Vector2i getTarg(int who);

    sf::Vector2i startPos[4],cherryPos;
    int mLives,mTotalPills,mCherryCountDown,mGhostKillStreak;
    PacEntity guys[5];
    std::deque<PacEvent> mEventsList;
    PacEntity::eDirection getNextMove(PacEntity& ent);


};
}
}

#endif // ENGINE_H_INCLUDED

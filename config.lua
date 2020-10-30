Config = {}

Config.DrawDistance = 5                             -- Distance they can see the pumpkin marker from (Default 3)
Config.Chance = 1                                   -- Chance that someone is home at a house. ex. 3 is a 1 in 3 chance someone is home and they get candy (Default 3)
Config.LargeHouse = 3                               -- This means a large house will give 1 to 3 candy (Default 3)
Config.MediumHouse = 2                              -- This means a medium house will give 1 to 3 candy (Default 2)
Config.SmallHouse = 1                               -- This means a small house will give 1 to 3 candy (Default 1)

-- Below are the coords for the houses
Config.Houses = {

    Houses = {
        LargeHouses = {
            vector3(-400.16, 665.01, 163.83),
        },

        MediumHouses = {
            vector3(1367.32, -606.33, 74.71),
        },

        SmallHouses = {
            vector3(-14.22, -1441.84, 31.1),
        },
    },
}

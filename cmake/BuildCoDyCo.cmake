# CoDyCo
include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(ICUB QUIET)
# orocos_kdl and package kdl_codyco use export(PACKAGE <pkg>) that
# installs some files in ~/.cmake/packages/<pkg> that are used by cmake
# to locate the build directory for some packages.
# This messes up with the superbuild, because CMake will find the build
# directory, and therefore will not rebuild the package.
# Therefore we disable the package registry using
# NO_CMAKE_PACKAGE_REGISTRY
find_or_build_package(orocos_kdl QUIET NO_CMAKE_PACKAGE_REGISTRY)
find_or_build_package(kdl_codyco QUIET NO_CMAKE_PACKAGE_REGISTRY)
find_or_build_package(kdl_format_io QUIET NO_CMAKE_PACKAGE_REGISTRY)


ycm_ep_helper(CoDyCo TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/codyco.git
              TAG master
              COMPONENT codyco
              CMAKE_CACHE_ARGS -DCODYCO_TRAVIS_CI:BOOL=ON
                               -DSIMULINK_LIBRARY:BOOL=OFF
                               -DCODYCO_USES_URDFDOM:BOOL=ON
              DEPENDS YARP
                      ICUB
                      orocos_kdl
                      kdl_codyco
                      kdl_format_io)

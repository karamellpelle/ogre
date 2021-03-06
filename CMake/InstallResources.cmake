#-------------------------------------------------------------------
# This file is part of the CMake build system for OGRE
#     (Object-oriented Graphics Rendering Engine)
# For the latest info, see http://www.ogre3d.org/
#
# The contents of this file are placed in the public domain. Feel
# free to make use of it in any way you like.
#-------------------------------------------------------------------

##################################################################
# Generate and install the config files needed for the samples
##################################################################

if (WIN32)
  set(OGRE_MEDIA_PATH "Media")
  set(OGRE_MEDIA_DIR_REL "${CMAKE_INSTALL_PREFIX}/${OGRE_MEDIA_PATH}")
  set(OGRE_TEST_MEDIA_DIR_REL "../Tests/${OGRE_MEDIA_PATH}")
  set(OGRE_PLUGIN_DIR_REL "${CMAKE_INSTALL_PREFIX}/bin")
  set(OGRE_SAMPLES_DIR_REL ".")
  set(OGRE_CFG_INSTALL_PATH "bin")
elseif (APPLE)
  set(OGRE_MEDIA_PATH "Media")
  if(APPLE_IOS)
    set(OGRE_MEDIA_DIR_REL "${OGRE_MEDIA_PATH}")
    set(OGRE_TEST_MEDIA_DIR_REL "../../Tests/${OGRE_MEDIA_PATH}")
  else()
    if(OGRE_INSTALL_SAMPLES_SOURCE)
      set(OGRE_MEDIA_DIR_REL "../../../${OGRE_MEDIA_PATH}")
    else()
      set(OGRE_MEDIA_DIR_REL "../../../../Samples/${OGRE_MEDIA_PATH}")
      set(OGRE_TEST_MEDIA_DIR_REL "../../../../Tests/${OGRE_MEDIA_PATH}")
    endif()
  endif()
  set(OGRE_PLUGIN_DIR_REL "")
  set(OGRE_SAMPLES_DIR_REL "")
  set(OGRE_CFG_INSTALL_PATH "bin")
elseif (UNIX)
  set(OGRE_MEDIA_PATH "share/OGRE/Media")
  set(OGRE_MEDIA_DIR_REL "${CMAKE_INSTALL_PREFIX}/${OGRE_MEDIA_PATH}")
  set(OGRE_TEST_MEDIA_DIR_REL "${CMAKE_INSTALL_PREFIX}/Tests/Media")
  set(OGRE_PLUGIN_DIR_REL "${CMAKE_INSTALL_PREFIX}/${OGRE_LIB_DIRECTORY}/OGRE")
  set(OGRE_SAMPLES_DIR_REL "${CMAKE_INSTALL_PREFIX}/${OGRE_LIB_DIRECTORY}/OGRE/Samples")
  set(OGRE_CFG_INSTALL_PATH "share/OGRE")
endif ()

# generate OgreConfigPaths.h
configure_file(${OGRE_TEMPLATES_DIR}/OgreConfigPaths.h.in ${OGRE_BINARY_DIR}/include/OgreConfigPaths.h @ONLY)

if(WIN32)
  # we want relative paths inside the SDK
  set(OGRE_PLUGIN_DIR_REL ".")
  if (WINDOWS_STORE OR WINDOWS_PHONE)
    set(OGRE_MEDIA_DIR_REL "${OGRE_MEDIA_PATH}")
    set(OGRE_TEST_MEDIA_DIR_REL "${OGRE_MEDIA_PATH}")
  else()
    set(OGRE_MEDIA_DIR_REL "../${OGRE_MEDIA_PATH}")
    set(OGRE_TEST_MEDIA_DIR_REL "../Tests/${OGRE_MEDIA_PATH}")
  endif()
endif()

# configure plugins.cfg
if (NOT OGRE_BUILD_RENDERSYSTEM_D3D9)
  set(OGRE_COMMENT_RENDERSYSTEM_D3D9 "#")
endif ()
if (NOT OGRE_BUILD_RENDERSYSTEM_D3D11)
  set(OGRE_COMMENT_RENDERSYSTEM_D3D11 "#")
endif ()
if (NOT MINGW AND CMAKE_SYSTEM_VERSION VERSION_LESS "6.0")
  set(OGRE_COMMENT_RENDERSYSTEM_D3D11 "#")
endif ()
if (NOT OGRE_BUILD_RENDERSYSTEM_GL)
  set(OGRE_COMMENT_RENDERSYSTEM_GL "#")
endif ()
if (NOT OGRE_BUILD_RENDERSYSTEM_GL3PLUS)
  set(OGRE_COMMENT_RENDERSYSTEM_GL3PLUS "#")
endif ()
if (NOT OGRE_BUILD_RENDERSYSTEM_GLES2)
  set(OGRE_COMMENT_RENDERSYSTEM_GLES2 "#")
endif ()
if (NOT OGRE_BUILD_PLUGIN_BSP)
  set(OGRE_COMMENT_PLUGIN_BSP "#")
endif ()
if (NOT OGRE_BUILD_PLUGIN_OCTREE)
  set(OGRE_COMMENT_PLUGIN_OCTREE "#")
endif ()
if (NOT OGRE_BUILD_PLUGIN_PCZ)
  set(OGRE_COMMENT_PLUGIN_PCZ "#")
endif ()
if (NOT OGRE_BUILD_PLUGIN_PFX)
  set(OGRE_COMMENT_PLUGIN_PARTICLEFX "#")
endif ()
if (NOT OGRE_BUILD_PLUGIN_CG)
  set(OGRE_COMMENT_PLUGIN_CG "#")
endif ()
if (NOT OGRE_BUILD_PLUGIN_STBI)
  set(OGRE_COMMENT_PLUGIN_STBI "#")
endif ()
if (NOT OGRE_BUILD_PLUGIN_FREEIMAGE OR OGRE_BUILD_PLUGIN_STBI)
  # has to be explicitely requested by disabeling STBI
  set(OGRE_COMMENT_PLUGIN_FREEIMAGE "#")
endif ()
if (NOT OGRE_BUILD_PLUGIN_EXRCODEC OR NOT OGRE_COMMENT_PLUGIN_FREEIMAGE)
  # overlaps with freeimage
  set(OGRE_COMMENT_PLUGIN_EXRCODEC "#")
endif ()
if (NOT OGRE_BUILD_COMPONENT_TERRAIN)
  set(OGRE_COMMENT_COMPONENT_TERRAIN "#")
endif ()
if (NOT OGRE_BUILD_COMPONENT_RTSHADERSYSTEM)
  set(OGRE_COMMENT_COMPONENT_RTSHADERSYSTEM "#")
endif ()
if (NOT OGRE_BUILD_COMPONENT_VOLUME)
  set(OGRE_COMMENT_COMPONENT_VOLUME "#")
endif ()
if (NOT OGRE_BUILD_COMPONENT_TERRAIN OR NOT OGRE_BUILD_COMPONENT_PAGING)
  set(OGRE_COMMENT_SAMPLE_ENDLESSWORLD "#")
endif ()
if(NOT OGRE_BUILD_TESTS)
  set(OGRE_COMMENT_PLAYPENTESTS "#")
endif()


# CREATE CONFIG FILES - INSTALL VERSIONS
set(OGRE_BUILD_SUFFIX "_d")
configure_file(${OGRE_TEMPLATES_DIR}/resources.cfg.in ${OGRE_BINARY_DIR}/inst/bin/debug/resources_d.cfg)
configure_file(${OGRE_TEMPLATES_DIR}/plugins.cfg.in ${OGRE_BINARY_DIR}/inst/bin/debug/plugins_d.cfg)
configure_file(${OGRE_TEMPLATES_DIR}/quakemap.cfg.in ${OGRE_BINARY_DIR}/inst/bin/debug/quakemap_d.cfg)
configure_file(${OGRE_TEMPLATES_DIR}/samples.cfg.in ${OGRE_BINARY_DIR}/inst/bin/debug/samples_d.cfg)
configure_file(${OGRE_TEMPLATES_DIR}/tests.cfg.in ${OGRE_BINARY_DIR}/inst/bin/debug/tests_d.cfg)

set(OGRE_BUILD_SUFFIX "")
configure_file(${OGRE_TEMPLATES_DIR}/resources.cfg.in ${OGRE_BINARY_DIR}/inst/bin/release/resources.cfg)
configure_file(${OGRE_TEMPLATES_DIR}/plugins.cfg.in ${OGRE_BINARY_DIR}/inst/bin/release/plugins.cfg)
configure_file(${OGRE_TEMPLATES_DIR}/quakemap.cfg.in ${OGRE_BINARY_DIR}/inst/bin/release/quakemap.cfg)
configure_file(${OGRE_TEMPLATES_DIR}/samples.cfg.in ${OGRE_BINARY_DIR}/inst/bin/release/samples.cfg)
configure_file(${OGRE_TEMPLATES_DIR}/tests.cfg.in ${OGRE_BINARY_DIR}/inst/bin/release/tests.cfg)


# install resource files
install(FILES 
  ${OGRE_BINARY_DIR}/inst/bin/debug/resources_d.cfg
  ${OGRE_BINARY_DIR}/inst/bin/debug/plugins_d.cfg
  ${OGRE_BINARY_DIR}/inst/bin/debug/samples_d.cfg
  ${OGRE_BINARY_DIR}/inst/bin/debug/tests_d.cfg
  ${OGRE_BINARY_DIR}/inst/bin/debug/quakemap_d.cfg
  DESTINATION "${OGRE_CFG_INSTALL_PATH}" CONFIGURATIONS Debug
)
install(FILES 
  ${OGRE_BINARY_DIR}/inst/bin/release/resources.cfg
  ${OGRE_BINARY_DIR}/inst/bin/release/plugins.cfg
  ${OGRE_BINARY_DIR}/inst/bin/release/samples.cfg
  ${OGRE_BINARY_DIR}/inst/bin/release/tests.cfg
  ${OGRE_BINARY_DIR}/inst/bin/release/quakemap.cfg
  DESTINATION "${OGRE_CFG_INSTALL_PATH}"
  CONFIGURATIONS Release RelWithDebInfo MinSizeRel None ""
)

# Need a special case here for the iOS SDK, configuration is not being matched, could be a CMake bug.
if (APPLE_IOS)
  install(FILES 
    ${OGRE_BINARY_DIR}/inst/bin/release/resources.cfg
    ${OGRE_BINARY_DIR}/inst/bin/release/plugins.cfg
    ${OGRE_BINARY_DIR}/inst/bin/release/samples.cfg
    ${OGRE_BINARY_DIR}/inst/bin/release/tests.cfg
    ${OGRE_BINARY_DIR}/inst/bin/release/quakemap.cfg
    DESTINATION "${OGRE_CFG_INSTALL_PATH}"
  )
endif()


# CREATE CONFIG FILES - BUILD DIR VERSIONS
if (NOT (APPLE_IOS OR WINDOWS_STORE OR WINDOWS_PHONE))
  set(OGRE_MEDIA_DIR_REL "${OGRE_SOURCE_DIR}/Samples/Media")
  set(OGRE_MEDIA_DIR_DBG "${OGRE_SOURCE_DIR}/Samples/Media")
  set(OGRE_TEST_MEDIA_DIR_REL "${OGRE_SOURCE_DIR}/Tests/Media")
  set(OGRE_TEST_MEDIA_DIR_DBG "${OGRE_SOURCE_DIR}/Tests/Media")
else ()
  # iOS needs to use relative paths in the config files
  set(OGRE_MEDIA_DIR_REL "${OGRE_MEDIA_PATH}")
  set(OGRE_MEDIA_DIR_DBG "${OGRE_MEDIA_PATH}")
  set(OGRE_TEST_MEDIA_DIR_REL "${OGRE_MEDIA_PATH}")
  set(OGRE_TEST_MEDIA_DIR_DBG "${OGRE_MEDIA_PATH}")
endif ()

if (WIN32)
  set(OGRE_PLUGIN_DIR_REL ".")
  set(OGRE_SAMPLES_DIR_REL ".")
elseif (APPLE)
  # not used on OS X, uses Resources
  set(OGRE_PLUGIN_DIR_REL "")
  set(OGRE_SAMPLES_DIR_REL "")
elseif (UNIX)
  set(OGRE_PLUGIN_DIR_REL "${OGRE_BINARY_DIR}/lib")
  set(OGRE_SAMPLES_DIR_REL "${OGRE_BINARY_DIR}/lib")
endif ()

if (WINDOWS_STORE OR WINDOWS_PHONE OR EMSCRIPTEN)
  # These platfroms requires all resources to be packaged inside the application bundle,
  # therefore install versions of configs would be copied and added as content file to each project.
elseif (MSVC AND NOT NMAKE)
  set(OGRE_BUILD_SUFFIX "_d")
  configure_file(${OGRE_TEMPLATES_DIR}/resources.cfg.in ${OGRE_BINARY_DIR}/bin/debug/resources_d.cfg)
  configure_file(${OGRE_TEMPLATES_DIR}/plugins.cfg.in ${OGRE_BINARY_DIR}/bin/debug/plugins_d.cfg)
  configure_file(${OGRE_TEMPLATES_DIR}/quakemap.cfg.in ${OGRE_BINARY_DIR}/bin/debug/quakemap_d.cfg)
  configure_file(${OGRE_TEMPLATES_DIR}/samples.cfg.in ${OGRE_BINARY_DIR}/bin/debug/samples_d.cfg)
  configure_file(${OGRE_TEMPLATES_DIR}/tests.cfg.in ${OGRE_BINARY_DIR}/bin/debug/tests_d.cfg)

  set(OGRE_BUILD_SUFFIX "")
  configure_file(${OGRE_TEMPLATES_DIR}/resources.cfg.in ${OGRE_BINARY_DIR}/bin/release/resources.cfg)
  configure_file(${OGRE_TEMPLATES_DIR}/resources.cfg.in ${OGRE_BINARY_DIR}/bin/relwithdebinfo/resources.cfg)
  configure_file(${OGRE_TEMPLATES_DIR}/resources.cfg.in ${OGRE_BINARY_DIR}/bin/minsizerel/resources.cfg)

  configure_file(${OGRE_TEMPLATES_DIR}/plugins.cfg.in ${OGRE_BINARY_DIR}/bin/release/plugins.cfg)
  configure_file(${OGRE_TEMPLATES_DIR}/plugins.cfg.in ${OGRE_BINARY_DIR}/bin/relwithdebinfo/plugins.cfg)
  configure_file(${OGRE_TEMPLATES_DIR}/plugins.cfg.in ${OGRE_BINARY_DIR}/bin/minsizerel/plugins.cfg)

  configure_file(${OGRE_TEMPLATES_DIR}/quakemap.cfg.in ${OGRE_BINARY_DIR}/bin/release/quakemap.cfg)
  configure_file(${OGRE_TEMPLATES_DIR}/quakemap.cfg.in ${OGRE_BINARY_DIR}/bin/relwithdebinfo/quakemap.cfg)
  configure_file(${OGRE_TEMPLATES_DIR}/quakemap.cfg.in ${OGRE_BINARY_DIR}/bin/minsizerel/quakemap.cfg)

  configure_file(${OGRE_TEMPLATES_DIR}/samples.cfg.in ${OGRE_BINARY_DIR}/bin/release/samples.cfg)
  configure_file(${OGRE_TEMPLATES_DIR}/samples.cfg.in ${OGRE_BINARY_DIR}/bin/relwithdebinfo/samples.cfg)
  configure_file(${OGRE_TEMPLATES_DIR}/samples.cfg.in ${OGRE_BINARY_DIR}/bin/minsizerel/samples.cfg)

  configure_file(${OGRE_TEMPLATES_DIR}/tests.cfg.in ${OGRE_BINARY_DIR}/bin/release/tests.cfg)
  configure_file(${OGRE_TEMPLATES_DIR}/tests.cfg.in ${OGRE_BINARY_DIR}/bin/relwithdebinfo/tests.cfg)
  configure_file(${OGRE_TEMPLATES_DIR}/tests.cfg.in ${OGRE_BINARY_DIR}/bin/minsizerel/tests.cfg)
else() # other OS only need one cfg file
  # create resources.cfg
  configure_file(${OGRE_TEMPLATES_DIR}/resources.cfg.in ${OGRE_BINARY_DIR}/bin/resources.cfg)
  # create plugins.cfg
  configure_file(${OGRE_TEMPLATES_DIR}/plugins.cfg.in ${OGRE_BINARY_DIR}/bin/plugins.cfg)
  # create quakemap.cfg
  configure_file(${OGRE_TEMPLATES_DIR}/quakemap.cfg.in ${OGRE_BINARY_DIR}/bin/quakemap.cfg)
  # create samples.cfg
  configure_file(${OGRE_TEMPLATES_DIR}/samples.cfg.in ${OGRE_BINARY_DIR}/bin/samples.cfg)
  # create tests.cfg
  configure_file(${OGRE_TEMPLATES_DIR}/tests.cfg.in ${OGRE_BINARY_DIR}/bin/tests.cfg)
endif ()


# Create the CMake package files
include(CMakePackageConfigHelpers)

if(WIN32 OR APPLE)
  set(OGRE_CMAKE_DIR "CMake")
else()
  set(OGRE_CMAKE_DIR "${OGRE_LIB_DIRECTORY}/OGRE/cmake")
endif()
configure_package_config_file(${OGRE_TEMPLATES_DIR}/OGREConfig.cmake.in ${OGRE_BINARY_DIR}/cmake/OGREConfig.cmake
    INSTALL_DESTINATION ${OGRE_CMAKE_DIR}
    PATH_VARS CMAKE_INSTALL_PREFIX)
write_basic_package_version_file(
    ${OGRE_BINARY_DIR}/cmake/OGREConfigVersion.cmake 
    VERSION ${OGRE_VERSION} 
    COMPATIBILITY SameMajorVersion)
install(FILES
   ${OGRE_BINARY_DIR}/cmake/OGREConfig.cmake
   ${OGRE_BINARY_DIR}/cmake/OGREConfigVersion.cmake
   DESTINATION ${OGRE_CMAKE_DIR}
)
install(EXPORT OgreTargets DESTINATION ${OGRE_CMAKE_DIR})
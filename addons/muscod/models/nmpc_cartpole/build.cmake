# Setup build environment
set(TARGET nmpc_cartpole)

ADD_LIBRARY ( ${TARGET} SHARED 
              ${SRC}/${TARGET}.cpp
            )

TARGET_LINK_LIBRARIES ( ${TARGET}
                        muscod_base
                        ${RBDL_LIBRARIES}
                        ${RBDL_LUAMODEL_LIBRARIES}
                        ${PGPLOT_CPGPLOT_LIBRARY}
                        ${PGPLOT_PGPLOT_LIBRARY}
                      )

grl_link_libraries(${TARGET} base)
install(TARGETS ${TARGET} DESTINATION ${GRL_LIB_DESTINATION})
install(DIRECTORY ${SRC}/../include/grl DESTINATION ${GRL_INCLUDE_DESTINATION} FILES_MATCHING PATTERN "*.h")


# Cartpole library links
execute_process(COMMAND ln -s -f ${CMAKE_CURRENT_BINARY_DIR}/libnmpc_cartpole.so ${SRC}/../../../cfg/inmpc_cartpole/libnmpc_cartpole.so)
execute_process(COMMAND ln -s -f ${CMAKE_CURRENT_BINARY_DIR}/libnmpc_cartpole.so ${SRC}/../../../cfg/nmpc_cartpole/libnmpc_cartpole.so)


FROM intel4coro/intel4coro-2dcoai-03c0a6:beb3648189fcd1754e0a0e535a3647af72ddba52

FROM intel4coro/base-notebook:20.04-noetic-vnc

ENV REPO_DIR=/home/${NB_USER}/COAI
ENV ROS_WS=/home/${NB_USER}/workspace/ros

USER ${NB_USER}
RUN rm -rf ${ROS_WS}/src
# COPY CRAM workspace
COPY --from=0 --chown=${NB_USER}:users ${ROS_WS}/src ${ROS_WS}/src

WORKDIR ${ROS_WS}/src
# Rebuild ROS workspace
USER root
RUN rosdep update && apt update && \
    rosdep install -y --ignore-src --from-paths ./ -r && \
    rosdep fix-permissions
USER ${NB_USER}
WORKDIR ${ROS_WS}
RUN catkin build

# The new base image has a new UI for the run code Button
# Uninstall the new UI and install the old one for Michael
RUN pip uninstall -y jupyterlab_examples_cell_toolbar
RUN pip install https://raw.githubusercontent.com/yxzhan/jlab-enhanced-cell-toolbar/main/dist/jlab-enhanced-cell-toolbar-4.0.0.tar.gz 

RUN mkdir ${HOME}/.binder
COPY --chown=${NB_USER}:users ./binder ${HOME}/.binder/

# Intall CommonLisp kernel.
RUN source ${ROS_WS}/devel/setup.bash && \
    /usr/bin/sbcl --load ${HOME}/.binder/sbcl-jupyter-kernel-installer.lisp

# Copy git repository to image
COPY --chown=${NB_USER}:users ./ ${REPO_DIR}
# Precompile and cache LISP code for demo notebooks
RUN source ${ROS_WS}/devel/setup.bash && xvfb-run /usr/bin/sbcl --load ${HOME}/.binder/pre-compile.lisp

COPY --chown=${NB_USER}:users ./binder/entrypoint.sh /
COPY --chown=${NB_USER}:users binder/webapps.json ${ROS_WS}/src/rvizweb/webapps/app.json

WORKDIR ${REPO_DIR}
ENTRYPOINT ["/entrypoint.sh"]

# Create a symbolic link to the ROS workspace under the working directory
RUN ln -s ${ROS_WS} ${PWD}/ROS_WS

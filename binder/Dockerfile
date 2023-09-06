FROM intel4coro/intel4coro:jupyterhub-ros-base-0.5

# Default ROS workspace
ENV ROS_WS=${HOME}/workspace/ros
ENV REPO_DIR=${HOME}/COAI
ARG CRAM_ROSINSTALL_FILE="https://raw.githubusercontent.com/cram2/cram/devel/cram-20.04-http.rosinstall"

# Copy git repository to image
COPY --chown=${NB_USER}:users ./notebooks/. ${REPO_DIR}/notebooks
COPY --chown=${NB_USER}:users ./binder ${HOME}/.binder

USER ${NB_USER}
WORKDIR ${ROS_WS}/src
# Install CRAM && Delete .git folder to reduce image size.
RUN wstool merge ${CRAM_ROSINSTALL_FILE} && \
    wstool update && \
    rm -rf */.git
# Install CommonLisp kernel. 
RUN catkin_create_pkg jupyter && \
    cd jupyter && \
    wstool init && \
    wstool merge ${HOME}/.binder/common-lisp-jupyter.rosinstall && \
    wstool update && \
    rm -rf */.git
# Install PyKDL
WORKDIR ${ROS_WS}/src
RUN git clone https://github.com/orocos/orocos_kinematics_dynamics.git orocos_kinematics_dynamics -b v1.5.1 && \
    cd orocos_kinematics_dynamics && git submodule update --init
# Install dependencies and build workspace
USER root
RUN rosdep update && \
    rosdep install -y --ignore-src --from-paths ./ -r && \
    rosdep fix-permissions
USER ${NB_USER}
RUN catkin build

# Fix 3d Meshes material files missing issue
RUN cd ${ROS_WS}/src/cram/cram_demos/cram_projection_demos/resource/household && \
    sed -i '3d' bowl.obj cup.obj

# Intall CommonLisp kernel.
RUN source ${ROS_WS}/devel/setup.bash && \
    /usr/bin/sbcl --load ${HOME}/.binder/sbcl-jupyter-kernel-installer.lisp

# Precompile and cache LISP code for demo notebooks
RUN source ${ROS_WS}/devel/setup.bash && xvfb-run /usr/bin/sbcl --load ${HOME}/.binder/pre-compile.lisp
# RUN jupyter lab workspaces import ${HOME}/.binder/workspace.json

# Compress texture files
RUN /opt/conda/bin/python ${HOME}/.binder/compress_textures.py --img_path=${ROS_WS}/src/iai_maps/iai_apartment/meshes/ --max_size=512


WORKDIR ${REPO_DIR}/
# Overwrite the entrypoint, and it has to end with `exec "$@"`.
# Do not start the juptyerlab server in the entrypoint script, it should be launched by the binderhub.
ENTRYPOINT ["/home/jovyan/.binder/entrypoint.sh"]

COPY --chown=${NB_USER}:users ./binder/app.json ${ROS_WS}/rvizweb/webapps/app.json

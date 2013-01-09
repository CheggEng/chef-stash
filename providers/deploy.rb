#
# Cookbook Name:: stash
# Provider:: deploy
#
# Copyright 2012
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

action :deploy do
  g = git new_resource.destination do
    repository "ssh://git@#{node['stash']['ssh']['hostname']}:#{node['stash']['ssh']['port']}/#{new_resource.project}/#{new_resource.repository}.git"
    revision new_resource.revision
    user new_resource.user
    group new_resource.group
    action new_resource.deploy_action
    ssh_wrapper "#{node['stash']['install_path']}/#{new_resource.deploy_key}_ssh_wrapper.sh"
  end

  new_resource.updated_by_last_action(g.updated?)
end

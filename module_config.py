
godot_branch = '3.x'

engine_repository = [ ['https://github.com/Relintai/godot.git', 'git@github.com:Relintai/godot.git'], 'engine', '' ]

module_repositories = [
    [ ['https://github.com/Relintai/entity_spell_system.git', 'git@github.com:Relintai/entity_spell_system.git'], 'entity_spell_system', '' ],
    [ ['https://github.com/Relintai/ui_extensions.git', 'git@github.com:Relintai/ui_extensions.git'], 'ui_extensions', '' ],
    [ ['https://github.com/Relintai/texture_packer.git', 'git@github.com:Relintai/texture_packer.git'], 'texture_packer', '' ],
    [ ['https://github.com/Relintai/godot_fastnoise.git', 'git@github.com:Relintai/godot_fastnoise.git'], 'fastnoise', '' ],
    [ ['https://github.com/Relintai/mesh_data_resource.git', 'git@github.com:Relintai/mesh_data_resource.git'], 'mesh_data_resource', '' ],
    [ ['https://github.com/Relintai/props.git', 'git@github.com:Relintai/props.git'], 'props', '' ],
    [ ['https://github.com/Relintai/mesh_utils.git', 'git@github.com:Relintai/mesh_utils.git'], 'mesh_utils', '' ],
    [ ['https://github.com/Relintai/thread_pool.git', 'git@github.com:Relintai/thread_pool.git'], 'thread_pool', '' ],
    [ ['https://github.com/Relintai/voxelman.git', 'git@github.com:Relintai/voxelman.git'], 'voxelman', '' ],
]

removed_modules = [
]

addon_repositories = [
]

third_party_addon_repositories = [
]

slim_args = 'module_webm_enabled=no module_arkit_enabled=no module_visual_script_enabled=no module_gdnative_enabled=no module_mobile_vr_enabled=no module_theora_enabled=no module_xatlas_unwrap_enabled=no'

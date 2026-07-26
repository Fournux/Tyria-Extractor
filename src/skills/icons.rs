use std::path::Path;

use crate::{atex, dat::DatArchive};

pub(super) fn export_skill_icon(
    archive: &mut DatArchive,
    texture_hash: u32,
    out_path: &Path,
) -> anyhow::Result<bool> {
    let Some(bytes) = archive.read_file_id(texture_hash)? else {
        return Ok(false);
    };
    atex::save_atex_as_png(&bytes, out_path)?;
    Ok(true)
}

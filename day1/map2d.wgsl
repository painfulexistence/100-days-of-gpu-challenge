@group(0) @binding(0) var<storage, read_write> a : array<f32>;
@group(0) @binding(1) var<storage, read_write> out : array<f32>;

// wgs is a vec3 containing workgroup size in x, y, z.
// the x component is wgs.x, y component is wgs.y, and z component
// is wgs.z

const wgs = vec3({{workgroupSize}});

@compute @workgroup_size({{workgroupSize}})
fn main(@builtin(local_invocation_id) lid: vec3<u32>) {
  let i = lid.x + wgs.x * lid.y ;
  out[i] = 10 + a[i];
}

  # OPA Policies for RTL AKS Platform

  Guard rails to ensure security, compliance, and cost optimization for workloads on the RTL Cloud & Data Platform.

  ## Policy Overview

  | Policy File | Purpose | Impact |
  |-------------|---------|--------|
  | `require-resources.rego` | Enforce resource limits/requests | Prevents resource exhaustion, enables capacity planning |
  | `deny-privileged.rego` | Prevent privileged containers | Security hardening, compliance |
  | `require-security-context.rego` | Enforce security best practices | Read-only filesystem, no privilege escalation |
  | `namespace-quotas.rego` | Namespace governance | Cost tracking, prevent default namespace usage |
  | `image-policy.rego` | Image registry and tag policies | Prevent :latest tags, enforce approved registries |

  ## Implementation at RTL

  These policies would be deployed using:
  - **OPA Gatekeeper** - Kubernetes admission controller
  - **Constraint Templates** - Rego policies converted to CRDs
  - **Constraints** - Policy enforcement per namespace/cluster

  ## Benefits

  1. **Security** - Prevent privileged containers, enforce non-root
  2. **Stability** - Resource limits prevent noisy neighbors
  3. **Cost Optimization** - Resource requests enable bin packing
  4. **Compliance** - Audit trail of policy violations
  5. **Developer Experience** - Clear error messages guide developers

  ## Example Violation Message

  Error from server: admission webhook denied the request:
  Container 'my-app' must have resource limits defined
  Container 'my-app' must use readOnlyRootFilesystem

  ## Next Steps for RTL

  1. Deploy OPA Gatekeeper to AKS
  2. Convert Rego policies to Constraint Templates
  3. Test in dev environment with audit mode
  4. Gradually enforce in test/prod
  5. Integrate with Sysdig for runtime compliance


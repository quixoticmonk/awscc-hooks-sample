# awscc-hooks-sample

CloudFormation Guard (cfn-guard) is a policy-as-code tool provided by AWS that allows you to define rules to prevent deployment of non-compliant infrastructure. These rules are written in a domain-specific language (Guard DSL) and can check for security best practices, compliance requirements, and organizational standards. For example, you can create rules to ensure all S3 buckets are encrypted, EC2 instances use specific instance types, or resources have required tags. Guard rules help enforce governance at scale by catching policy violations before resources are deployed in your AWS environment.

A CloudFormation Guard hook is a feature that integrates  Guard rules directly into the deployment process using AWS CloudFormation Hooks. It automatically evaluates your Guard rules during stack operations (create, update, or delete) and can prevent non-compliant infrastructure changes from being deployed.

Key points about CloudFormation Guard hooks:
1. They run pre-deployment validation checks
2. Can block  operations if rules are violated
3. Help enforce compliance automatically during infrastructure deployment
4. Can be configured at the organization level using AWS Organizations

This creates a proactive compliance mechanism rather than having to run Guard rules manually or through separate processes.

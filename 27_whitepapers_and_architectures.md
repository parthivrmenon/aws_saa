# Whitepapers and Architectures

# AWS Well-Architected Framework
## 6 Pillars:
- Operational Excellence
- Security
- Reliability
- Performance Efficiency
- Cost Optimization
- Sustainability

Principles:
- Stop guessing capacity
- Test systems at Production scale
- Automate everything
- Allow for evolitionary architectures
- Drive architecture decisions based on data
- Improve through game-days

## AWS Well-Architected Tool
Free tool to review your architecture against the AWS Well-Architected Framework.
How does it work?
- Select your workload.
- Select a Lens/Profile (AWS Well-Architected Framework being one of them)
- Answer questions for each of the Pillars
- Once you complete, Lens will:
    - show you your "risks"
    - show you recommendations for improvement

# AWS Trusted Advisor
Gives you a `high level assessment` of your AWS account.
Example Checks:
- Amazon EBS Public Snapshots
- Amazon RDS Public Snapshots
- IAM Use (discourage use of root account)

Analysis is grouped into 6 categories:
- Cost optimization
- Performance
- Security
- Fault tolerance
- Service Limits
- Operational Excellence

**Business & Enterprise Support**:
- access to full set of checks
- programmatic acces to AWS Support API

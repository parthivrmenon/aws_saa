# S3 Storage Classes

By default, all objects are stored in `S3 Standard (STANDARD)` storage class. You can change the storage class to optimize costs and performance based on data access patterns.

### Storage classes for frequently accessed objects (Frequent Access or FA)
#### S3 Standard (STANDARD)
This is the default storage class and provides 99.99% availability. It has low latency and high throughput.

#### S3 Express One Zone (EXPRESS_ONEZONE)
Amazon S3 Express One Zone is a high-performance, single-zone Amazon S3 storage class that is purpose-built to deliver consistent, single-digit millisecond data access for your most `latency-sensitive applications`. 

**S3 Express One Zone is the lowest latency cloud object storage class available today**, with data access speed up to 10x faster and with request costs 50 percent lower than S3 Standard. With S3 Express One Zone, your data is redundantly stored on multiple devices within a single Availability Zone.

### Storage class for automatically optimizing data with changing or unknown access patterns

#### S3 Intelligent-Tiering (INTELLIGENT_TIERING) 
is an Amazon S3 storage class that's designed to optimize storage costs by automatically moving data to the most cost-effective access tier, without performance impact or operational overhead. 

S3 Intelligent-Tiering is the ideal storage class when you want to **optimize storage costs for data that has unknown or changing access patterns.** There are no retrieval fees for S3 Intelligent-Tiering.

##### S3 Intelligent-Tiering automatically stores objects in three access tiers:

- **Frequent Access** – Objects that are uploaded or transitioned to S3 Intelligent-Tiering are automatically stored in the Frequent Access tier.

- **Infrequent Access** – S3 Intelligent-Tiering moves objects that have not been accessed in 30 consecutive days to the Infrequent Access tier.

- **Archive Instant Access** – With S3 Intelligent-Tiering, any existing objects that have not been accessed for 90 consecutive days are automatically moved to the Archive Instant Access tier.

In addition to these three tiers, S3 Intelligent-Tiering offers two optional archive access tiers:

- **Archive Access** – S3 Intelligent-Tiering provides you with the option to activate the Archive Access tier for data that can be accessed asynchronously. After activation, the Archive Access tier automatically archives objects that have not been accessed for a minimum of 90 consecutive days.

- **Deep Archive Access** – S3 Intelligent-Tiering provides you with the option to activate the Deep Archive Access tier for data that can be accessed asynchronously. After activation, the Deep Archive Access tier automatically archives objects that have not been accessed for a minimum of 180 consecutive days.


### Storage classes for infrequently accessed objects

The `S3 Standard-IA` and `S3 One Zone-IA` storage classes are designed for long-lived and infrequently accessed data. (IA stands for infrequent access.) S3 Standard-IA and S3 One Zone-IA objects are available for millisecond access (similar to the S3 Standard storage class). Amazon S3 charges a retrieval fee for these objects, so they are most suitable for infrequently accessed data

#### S3 Standard-IA (STANDARD_IA)
Amazon S3 stores the object data redundantly across multiple geographically separated Availability Zones (similar to the S3 Standard storage class). S3 Standard-IA objects are resilient to the loss of an Availability Zone. This storage class offers greater availability and resiliency than the S3 One Zone-IA class. To help you optimize costs between S3 Standard and S3 Standard-IA you can use Amazon S3 analytics – Storage Class Analysis

#### S3 One Zone-IA (ONEZONE_IA)
Amazon S3 stores the object data in only one Availability Zone, which makes it less expensive than S3 Standard-IA. However, the data is not resilient to the physical loss of the Availability Zone resulting from disasters, such as earthquakes and floods. The S3 One Zone-IA storage class is as durable as S3 Standard-IA, but it is less available and less resilient. 


We recommend the following:

- S3 Standard-IA (STANDARD_IA) – Use for your primary or only copy of data that can't be re-created.
- S3 One Zone-IA (ONEZONE_IA) – Use if you can re-create the data if the Availability Zone fails, for object replicas when configuring S3 Cross-Region Replication (CRR). Also, for data residency and isolation, you can create directory buckets in AWS Local Zones and use the S3 One Zone-IA storage class.


### Storage classes for rarely accessed objects

The `S3 Glacier Instant Retrieval (GLACIER_IR)`, `S3 Glacier Flexible Retrieval (GLACIER)`, and `S3 Glacier Deep Archive (DEEP_ARCHIVE)` storage classes are designed for low-cost, long-term data storage and data archiving. These storage classes require `minimum storage durations` and `retrieval fees` making them most effective for rarely accessed data.

#### S3 Glacier Instant Retrieval (GLACIER_IR)
Use for long-term data that's rarely accessed and requires milliseconds retrieval. Data in this storage class is available for real-time access. Minimum storage duration of 90 days.

`S3 Glacier Flexible Retrieval` and `S3 Glacier Deep Archive` are archival storage classes. This means that when you store an object in these storage classes that object is archived, and cannot be accessed directly. To access an archived object, you submit a restore request for it, and then wait for the service to restore the object. 

#### S3 Glacier Flexible Retrieval (GLACIER)
Use for archives where portions of the data might need to be retrieved in minutes. Data in this storage class is archived, and not available for real-time access. Minimum storage duration of 90 days and typical retrieval time of 1-5 minutes for expedited retrieval and 3-5 hours for standard retrieval.

#### S3 Glacier Deep Archive (DEEP_ARCHIVE)
Use for archiving data that rarely needs to be accessed. Data in this storage class is archived, and not available for real-time access. Minimum storage duration of 180 days and typical retrieval time of 12 hours for standard retrieval and 48 hours for bulk retrieval.





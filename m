Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.112])
 by mx.groups.io with SMTP id smtpd.web10.14061.1713777350426898752
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Apr 2024 02:15:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTNpHLnFNMQoQnb6BugzvODJ6TVotGPovPse8UFWL40=;
 b=S1voAtLDmSo/icpCdU/x4tLsU3//6FL7d7PVsl51g7u39N77WbVoDgjVF0tu3Z2t3Rv+r4KG2M628v683Ks8PLHk9gTM8IVgXN+ETvnofuf+V8zA3y4sCqUfWhGKwK+aqdmqrf1Kqq6hNd26lmBCwyLIIKQ1fdsckJ+qgwvkK07c3t+h/DyOwSmfRrtpKEk8EpUoQ48nh069DBLLIC9udGRon7lUcosCwRWig3BCDczGt1X5OKHjMVQez11JvZVNRVOqlvv+QUGok1xcR7D1Wsr8MiTwsDMs+KCy6DwpYS7k9l9Ix+LrCjOlxB7xJXXgmz+FvxAmo6oEavnElnUWoQ==
Message-ID: <bb0298ac-061a-4a2c-9316-789b9ef29d9c@theobroma-systems.com>
Date: Mon, 22 Apr 2024 11:15:45 +0200
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] wic: add GPT partition names to partitions
References: <20240418220431.31286-1-twoerner@gmail.com>
From: "Quentin Schulz" <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240418220431.31286-1-twoerner@gmail.com>
Return-Path: quentin.schulz@theobroma-systems.com
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: yocto-patches@lists.yoctoproject.org
List-ID: <yocto-patches.lists.yoctoproject.org>

Hi Trevor,

On 4/19/24 00:04, Trevor Woerner via lists.yoctoproject.org wrote:
> A filesystem label (/dev/disk/by-label) is a property of, and stored in, the
> filesystem itself. Partitions that are not destined to hold filesystems are
> not formatted, therefore it is not possible to assign filesystem labels to
> such partitions.
> 
> However, if GPT partitioning is being used, GPT supports the notion of
> assigning labels/names to the partitions which are stored as part of the GPT
> partition table itself (instead of being stored in the filesystem in the
> partition). The naming is a bit confusing (different tools use different
> names) but `wic` calls this "--part-name", `lsblk` calls this "PARTLABEL", and
> `parted` calls this "name".
> 
> In Linux user-space these partition labels are referenced via
> /dev/disk/by-partlabel and provide an excellent way of finding these GPT
> partitions regardless of which backing device is actually being used (e.g.
> mmcblk0, mmcblk1... i.e. emmc, sdcard...).
> 
> An example where this would be handy is for interacting with a stored U-Boot
> environment. Another potential use would be to use one of the unused raw
> partitions to store information such as MAC addresses, serial numbers, etc.
> which could be set/updated "at the factory" as images are flashed.
> 
> Tested with both systemd and sysvinit on both rock-pi-e and rock-pi-s.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin

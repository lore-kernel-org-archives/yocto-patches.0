Received: from BL0PR03CU003.outbound.protection.outlook.com (BL0PR03CU003.outbound.protection.outlook.com [52.101.53.38])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.374.1794855367966777031
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 10:56:08 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=b7ScJ8gR;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.53.38, mailfrom: mark.hatle@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOmkViilTN3YjpanWni31u1mnuxl6db+1Q+j3QQD2uV+WV9PdeYfsVkLq5mz2OwsqpxhOs9g4KNEQ/W0iXsSoYMDBmtgixPgAI8eptp2vfxb0MZ6bGQD8TKH26O33S7KyMus1eeu+ilk9P+Gy5YOB2CaVg4ES2VcwB+gcvS4Ewt/MdiawoSNCbViPwMzaFk/UyVfDqbpYuTQ/8N9HYBekVfU2H+F2/iXma00XXyGBSpkdOzd9lYgN+yLgunUeG/D+R4syNhgKMh9n54gLF6uFKWqddVVPDeokJ/thrQA3tyrBVMsmAZEd5N86naGoh6TVqbXDjSsM3M8u0EwEcybpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rye1gIUV2SlmUZ26Rn438mWAsMhy1A61/nwzj56uaMA=;
 b=qL5F9oStTO5v+KDJg8WTo/3uq8SdhJRlCyrv7ESJM967A53U8nR8inVfAfFhX8Pys2a5GUd2J6Qf3iVrgFr/ACMG2WrYZPhfs7Lr6Ja1Dg+3Ykk/Z9GgVWNYv12dmLQXmNTagzaNYlcuHIfWpOyhxT149Fmy1AC4WmLdycxwNbYW+3zEAQmJe9Pe7hlcwa5XmgH61+lBlxLeaEeZHZa2hnGAssT4k97xDJJSnsReBkkFSTBMUypkpeI9coIb1hZLCcJZA8rr6hqhiGkWjNe0d6jQ1uCQwiAiTP91WBa0YX4fNnTYXVhq7gCr+bMhNohkApbK6CMP+Pm8q3Drecypew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rye1gIUV2SlmUZ26Rn438mWAsMhy1A61/nwzj56uaMA=;
 b=b7ScJ8gROJZEKf5sDy/yL5V+1ZiNVJkZ1U9JWMmn1ieuWTcKNNaCw1ia4wJSEcEsUM2W093MxeMAyQeyrHeWdKR8TzOIU8vbFhU+PxtPS7NaphLaRro3N6tQ/VrWI+cb+I6MChCy5RAwGKQ46KiC1YOIf+dauFuvkYukU4z+RGo=
Received: from BN0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:408:e6::19)
 by IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Mon, 16 Nov
 2026 18:54:00 +0000
Received: from BL6PEPF0006C3DD.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::18) by BN0PR03CA0014.outlook.office365.com
 (2603:10b6:408:e6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 18:54:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0006C3DD.mail.protection.outlook.com (10.167.249.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 16 Nov 2026 18:54:00 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 12:54:00 -0600
Received: from xcolc230100.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Mon, 16 Nov 2026 12:54:00 -0600
From: Mark Hatle <mark.hatle@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [pseudo][PATCH 0/3] Implement io_uring wrapping
Date: Mon, 16 Nov 2026 11:53:57 -0700
Message-ID: <20261116185400.2205466-1-mark.hatle@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-Path: mark.hatle@amd.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3DD:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c17c99-999e-4049-a9a3-08df4412fa27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|261009223027099003|11063799006|56012099006|261102123227099003|261028144727099003|261026121527099003|261026135527099003|261026140227099003|261021121427099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: UnXbcNINi2oyyUeE7Q/9v/YrgMA7Z8L2LBz0+dZE343XUdxPF8iskaD8wK5HRz0UePs8ZTmUkwwZmVP7k9PxYC6k6ggagzO68YjhIUpX9z/39+TD0QyrqhfgyKDdTPOv/DgCS/CktxRl6hEboifqQgIJA0UrF36haW6CfJchwyt68FAHKrTFow+OfUuOjDbYExUk+3x1S+BtvvlQbtQUz7XJRRV6YU/WHWNLwRmdRMEn1ojFuub10o/0mWIUeiGmvV4zvNcx4328X0TjrHo66f3mGE72dHbFaJ3fbBW4UlBeAORLjwbkWfAtnRNl4YsX/cE1yJ/0MUV5+cK4FSwSb8Nk3O6Bq3AHsFzsg3VS2vR/VmjONkFup8011lD2SQ6gw1c7XWEJEOaNRvvhfwiZq4DMLVF6RBhCrMPKHOULlZKURDa7CbOc6TCNigjL/4TiDqK2WkUix1ciuTkJnJELRKl/W94RPE3LwPvpDcN0a+qiZCs6Z3xitkNVUUZO0yLmA+VfhZh4QlZ23eZwgz5IvnmlYSpFlxbymqx+Zi7XOO5pC5aD/BRkKATOISBq53KbxWUyMt8LGg9JbzimqiAbIXDRY6SOLrLCzGq+VzXu6BYG13owehgWx1CP1qm+emwoTzVtyNpMHeyI+h8NChliKyAw0h/xHEnlHQVJsr16U3I0kCJ+tJKhSA9qC9ym9Xnkbeo7jKw/FGo1oj9hgbOhVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026135527099003)(261026140227099003)(261021121427099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: htPSxHN/uYlkqd8zgmqt/XDMqkYS/h6jGCxWkbRIwX2AGXpIRvKGNmx9XJwMtU2kJc0tdcgLQQ6nCvVLKZ74CQ0KP+v1bJaLhNbfH1nrb8x+lol/wkVbWG6wVuuAEbLf0XgC8RfIMhCMWdobWshmRpKfISoYPlYkX9CUgIx4YN4EeYn/JGE2s95dC5ROO6CpY/RFEJWYgL0wbW0zce+5bSLrGyI7gmGp+8aHeahJZHYPLNKWPzrRhFdhxQicfRjyv/Wlm5OGDVv6uKLNTz+z5m7+iLCead7KsJEBJTg1ifo8elCKHEV8/cgAIrwKuA/r+iyPcQNuwlXyqqDo/OtLje1brPa2P0bNiK9sVclSQkGWwEB6tVjU0OsrbwkKI9CYidlZ5NyScvh75nqX6wZuGED9PGIBfYAaW/XRCKeacioSASOfQoBecS2+u2vmdVMd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 18:54:00.6466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c17c99-999e-4049-a9a3-08df4412fa27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0006C3DD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 18:56:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5414

[YOCTO #15244]

Implemented via a combination of intercepting the syscalls as well as tryin=
g to use seccomp to prevent the call from working if a user bypasses our sy=
scall wrapper.

David Nystr=C3=B6m (1):
  ports/linux: Refuse io_uring in the kernel rather than be bypassed by
    it

Mark Hatle (2):
  ports/linux/pseudo_wrappers: Report io_uring as unsupported in
    syscall()
  README.security: Describe io_uring refusal and the host fallback

 Makefile.in                           |   1 +
 README.security                       |  16 ++
 ports/linux/io_uring_syscalls.h       |  72 +++++
 ports/linux/portdefs.h                |   2 +
 ports/linux/pseudo_io_uring_seccomp.c | 363 ++++++++++++++++++++++++++
 ports/linux/pseudo_wrappers.c         |  24 ++
 pseudo.1                              |  79 ++++++
 pseudo_util.c                         |   2 +
 pseudo_wrappers.c                     |  11 +
 test/test-io-uring-deny.c             | 267 +++++++++++++++++++
 test/test-io-uring-deny.sh            |  16 ++
 test/test-io-uring-syscall.c          |  47 ++++
 test/test-io-uring-syscall.sh         |   7 +
 13 files changed, 907 insertions(+)
 create mode 100644 ports/linux/io_uring_syscalls.h
 create mode 100644 ports/linux/pseudo_io_uring_seccomp.c
 create mode 100644 test/test-io-uring-deny.c
 create mode 100755 test/test-io-uring-deny.sh
 create mode 100644 test/test-io-uring-syscall.c
 create mode 100755 test/test-io-uring-syscall.sh

--=20
2.34.1


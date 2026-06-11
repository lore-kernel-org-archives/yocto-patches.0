Return-Path: <anders.heimer@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816EBCD98CE
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 06:13:48 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.16])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39387.1781158419335035151
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Jun 2026 23:13:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@est.tech header.s=selector1 header.b=pJdS6poM;
 spf=pass (domain: est.tech, ip: 40.107.130.16, mailfrom: anders.heimer@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPKH3hwpp7+0uKxjqL4zfJfRKTmg6MJnUlQEWPRoSwtCJy50LlxwAv3y6x7VumVBhUEFT4ElvYAEWHDD6i7sF/BU3NpCPVkh+NdSqo0Ia30oyT1CveOWwFym39vV35UaZKg9RweBXYZbmntqfDMELiZhvO2Fbtj7noQs1QGvJHoCRRLg7ZR6lEyZAPWdCihqMTq63zW2tJFFkTZVnNoFoPH1Z3oe9Y+hKEj/wepqc1c1zMa6HL0VQirTHVlkeH1C+ijV/mdUqrssgrWMQkQyPP8tPwK9Rqf4gKaIBjSnSWby/Rk4YS9kWtcIvqtp4cmJyNebnR5yPQGJKCSoCwrE6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5iCE+jm2gGpVSoCAkIM31PjKMUsgp0X/ktSJgSnoLA=;
 b=QmUm2vyXbIGrfNKWDFSxHuaH60g6+EEWGzhu52ildjRJUzoA6y0Im6wz4em3dBy+FE/JnKb+BRwGDOc8Pc0oplbsPqEhFwb54ImTr7wCHZU4Ew4fItT4S4SpLLrYyYPl76ZzfWWdk3PzfviuNkvQrozfPNY3oTR4uLeLQCSpEfb8/1uhdAi17TPYKkpvBD9EGgDyAc7XAAlH98j8JupPXB4qJ6qMUrgPE0Lm57UckVoZ48FwU6a08qXqPO8LS3uYSjegLo37a0I6dDO6lDbFac+WgciYl/hmvdA9m8TJsdrzP2MN1qG47Jl+4Z6U7whRy85Qbpgxa70qa2cYqX3tkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5iCE+jm2gGpVSoCAkIM31PjKMUsgp0X/ktSJgSnoLA=;
 b=pJdS6poMVjEmTp1CEoYV9yEYr3lXs2mYXJuRWoh7UBE12vNKkTybP46KYoBtiFu9CJSNfw3k4CV67rpNmfagy6oGMCvOFRNoPjoIAzW571l+VeMt2uuq3+zZeaf9AatahXprAZp5xndM5QoI29vaAvxxh9arkCOEi0dfytDB+qFNKRWQLuXL7aRXTFqDbbr5Y3XPwjrZpxVt/anzMClZOvD6HqoMR9t5kxZgO3pTw3VHL5tSCvDpWb7mCG+6DI5LOHV7nhmWuuZhm/gn+myhYpx2wYANgUW+56wJYD+9ILQJiSLwph7+lD+Sw0MlKEfBF2cCFiIJensTKKnIeaaheg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2ac::9) by
 GV1P189MB3003.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:263::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.12; Thu, 11 Jun 2026 06:13:32 +0000
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82]) by DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82%6]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 06:13:32 +0000
From: Anders Heimer <anders.heimer@est.tech>
To: yocto-patches@lists.yoctoproject.org
CC: anders.heimer@est.tech
Subject: [yocto-autobuilder2][PATCH 0/3] Avoid shell use
Date: Thu, 11 Jun 2026 08:13:27 +0200
Message-ID: <20260611061330.733392-1-anders.heimer@est.tech>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: DU2PR04CA0293.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::28) To DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:2ac::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1641:EE_|GV1P189MB3003:EE_
X-MS-Office365-Filtering-Correlation-Id: f75565b1-87cb-44ef-1df1-08dec7809084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|18002099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: 
	LiG0pNvYgx4MSK/NsZe+/qqRAtR4dybpqEZ51TNxMw0WG/mPNp7oDCAgE/RCKN/hQFOP5n03ukAYn+ETPNFH1ZBCYc0l6Qlk+L8ZIyhCdVKu5b8floq2k2ZA95hvzOudjcvTG/RSCzQsL+nTN1jBbuX4PTA3W4sRlAJ8SpO+gJ99k5xOjec/E7MrSubQ+sIGn6jmLKoFck7teYPJe5fjdqtnpkW3ik/cq/gjrkHag6KZrDyFfWw+Br9FvJQbpj23dnnYwo5yiGNf+Pz+i4yfDq1zbMyS+BNn8U2Wn/omQKfqUP8gJSwvK6aNMArFrvEIZ65t9HTkIiiOISzFmr4CKI2jV9u/iqjbC3iTOwZR50JFA6UxZoeSP23cdxzBlGmmS3PYL9vPcY11GmyCIFvkmgkujBfystdlcuki6TdIi3ScJE9DLD+dZ8PZZhbOFIHtdkzjqiIVKe/viGahpsmF5idMqacEWlgBs0RUPvPJNLTjO913h1j7x0wglH1kP3Q27VyJA+/PLPOelsWRAed0/Desnog+agoWtFfzEoN6hSBGmH9/1d6ksD2shi6BYvM7Lsv92Rj/4+gk9keTDlvsYw1KafZu3ibsd0Oc5+7UknWsR3cVFTM5/f7J4cxpHO053Fe0+UgUK/cBElF6prCZxOzl/UjAs97q2gNUHLMwKVWBg8AG+74A2VLBMbDhMuUA
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1641.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SovS5eiXTeArKUTxrIA1e6H/q29fjSH8dfBouxaoRzY9mto6mey2dV/r29Z1?=
 =?us-ascii?Q?4D2hWNeyPeKzEdyD3fIhTgHPqkXbxcFSc2Osu4Zk+AvoAQj0G6KXwSiWqXEj?=
 =?us-ascii?Q?fZGym5fUdnEhB2sIUSTzB2BtPGddV83Jol8STdpGDETMFBM7y2kht+yJHQPd?=
 =?us-ascii?Q?b1EqkYHItnnulnFcUHu/PU/uoGz5hOn70Su/6KZ1uvvEPW2xHykQD4CDRz3z?=
 =?us-ascii?Q?9+OoZoWL/y4n23fbxI6KcNRmqMEMgvzxqKsjTNdoXOJxKIYX49GnQTph2/+w?=
 =?us-ascii?Q?spW5qY5rbROIyk6V6ctUKVTg2VB+FtrAenJib88WBTxfPPYAmO4lAGwA0usc?=
 =?us-ascii?Q?irrkiIKkwE+F9b1m0CsZKHMSowe1k1M7VmapevMSkM54SS870Yvsxm3l1Vwc?=
 =?us-ascii?Q?XQQYG4XF8WCJ6uatOrw6Iz1U+yB2IhVtUhBNki4O7oq9eYLznQ9+ldc0ki1/?=
 =?us-ascii?Q?C8PNtyIIKuz1p0sNlSSa99Co71X0s0b8bezqqhb/MtTAALpuXQVd45IR4foB?=
 =?us-ascii?Q?htdVOJrDxT9YybzStMzRN2eX3v0DjhVN1CMhn7KaYm+DUfIay5/+0QFXIzH5?=
 =?us-ascii?Q?NDD41wIXzWI0pWSBKE1rq+nfJEXyhZCd4bxuZ7L3iAemKL2yMxvFjtF0Gnv1?=
 =?us-ascii?Q?sEW/eBLQ5jonrTlKF9iLSL+KRbYfVJC+7gEF8WIVFukbMm2H5Bpe4ln8kmDT?=
 =?us-ascii?Q?s8UaBiBQ94hdd0R5pqZzWdjgEpbU30DoviaX/UUZUlAJ/X4n/8iTYydYVaJw?=
 =?us-ascii?Q?g7+wDpFLmUqvkzK5B0CkB4aXWOvr3+i2dBRdRrxxtQRvyOvGHeZUQJAjFB2K?=
 =?us-ascii?Q?d7fLjm7rtBaquJCgEzfDSvWPidFJH9CIAvxXEEQkyIM5baTiu/Hzuklu7T9t?=
 =?us-ascii?Q?BbmYHlVoa9mRxRk0j1x74e/QjKZd1ydusQppgmLaykw8PxFKZxUvOC1GRl6O?=
 =?us-ascii?Q?hJ1Agtuw3/2435FxMfVHHHtq1osLjnbXvCaB5VFNrvSxJs28HrbpjSiDTe8E?=
 =?us-ascii?Q?FHnb4NCKedRTpmxbxMQARZNFtzvGqU/ZK9Capce1K7aDRs8A8ujiQaqf7cmC?=
 =?us-ascii?Q?5FNNxQ218k6x+t9XX1zUhMofec5Grk98OyypwyOaCZGFDFLN0jAuvjtK3vxO?=
 =?us-ascii?Q?cjYneKgTlPgArZjC7r1I1VU05dVx80L1XxylTiP74LIqCN2vgkupzyL3HfzE?=
 =?us-ascii?Q?UGTKzj5Q3IjP2sdX634So8xSiXaiCQ8hxmHs+ph2xFdZXGZTuGcHCtd9Mm3o?=
 =?us-ascii?Q?h3WVdUOp8BISyued//oR0/RJJqr3bJMZl25oTzdSEOb/Q+vag9BTSmxl4voB?=
 =?us-ascii?Q?j/9oPwuuJkaHx5Zr7qLndT5/QqvFSjKb2iaRO7WRSeeVhGC4drNqPeA/bUvX?=
 =?us-ascii?Q?nxgAJrZUXZbCcuP8g7yDBMQm+xvzzzNcO+4YnC77KDZXrKsPaIwqcbJBDXwo?=
 =?us-ascii?Q?nAuAcVr+7yf7amWIZQjSOHeQks2RS8HQIaBwA23EZtCFKOna1rHujjJrl6wu?=
 =?us-ascii?Q?AOngbWrrTDPEdtYRwdH/J5FpjCTrO1h2KouH5mBe40kTcvRH3D/yPP6J1tCM?=
 =?us-ascii?Q?ZpGj9R0E/H193zmtHBOQu3pozeXjFm3Q/j1Tk108eFyLERKrGjowrMm/pvqV?=
 =?us-ascii?Q?phEPPR5fyypuAb1hd7pKPg3WdnXdsI+pB3pd1Qdit9DI28YrqkUUwMzLpkeX?=
 =?us-ascii?Q?NNlg9xy7nKmhP4AU2O2saKLa6H7B0xBDae6Y4npUG16KuS0AOgMlhd+xUd89?=
 =?us-ascii?Q?VnRuIw9ztA=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: f75565b1-87cb-44ef-1df1-08dec7809084
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 06:13:32.8233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtAgitUQI0fmMCZKZUh2O4oJEZMpf9NJ+A4ySv9DFUzWCKn/rxcdqIXPrY7IN53s1vKgv8cqdH8R3dLuhRYulA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P189MB3003
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 11 Jun 2026 06:13:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4206

This series removes shell use from a few backend paths where Buildbot
already has structured command arguments or generated file contents.

The changes are intended as hardening/cleanup with no intentional
behaviour change.

Testing:
  * Metadata writers:
    - qemuarm-oecore build wrote layerinfo.json and
      bbsetup-overrides.json via StringDownload
    - both files parsed correctly and preserved repo, branch and revision
      values literally
    - whitebox comparison showed byte-for-byte identical output for
      qemuarm-oecore, a-quick, docs and default-repo fallback cases.

  * getproperties.py argv change:
    - live qemuarm-oecore build reached and passed "Load build revisions"
    - the step set 15 properties
    - Buildbot log showed direct argv execution:
          argv: [b'.../getproperties.py', b'.../build', b'qemuarm-oecore']
    - direct replay on a preserved qemuarm-oecore build tree matched the
      old shell-string output exactly.

  * Disk-space check:
    - live builds passed the canStartBuild disk gate and started normally
    - local comparison showed the old findmnt --df fifth field matched the
      new findmnt -o AVAIL output for ., /tmp and the worker tree

Anders Heimer (3):
  steps: avoid shell when writing repo metadata
  builders: pass getproperties command as argv list
  builders: avoid shell pipeline for disk space check

 builders.py               | 16 +++++++++++++---
 steps/writebbsetupjson.py | 19 +++++++------------
 steps/writelayerinfo.py   | 19 +++++++------------
 3 files changed, 27 insertions(+), 27 deletions(-)



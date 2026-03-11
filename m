Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81A2FD0638
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 06:48:37 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14795.1773211713273956376
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 23:48:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=dyKnK41/;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7530ed8fe6=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B53Y1E2763276;
	Tue, 10 Mar 2026 23:48:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=W7PzvfpKV
	JTg13vUI/SvpUnyNoNw/BDIxVNKRNdIMU0=; b=dyKnK41/C18ZPzp/qpPLG7lpb
	G7pm68AUbWZvKRQkJDrAQk5wGFfwSjuLtW0s+fucbeBIwOlm4lUAEf8CGTgyRTvk
	0x+Sde/MrVpe7DJfliv58bEyw6UchgEhe8/nXOT6UhP32JXxl9lFGsJ3vxb7Tj37
	y/yVtSsQfQtu7Dq8sVUzmDg7YLe5BcKJHbT1qc56d5DLfucREFMWwlqh2vJD8ZN8
	1Y3NuRcMemSDV6D/haoUHhdfymnNBMS+0R1tIILMop/EyWI4ZD11psYl2EHQb6fC
	P+3FkSI+kwInvHJMIckAEoATG7zSnw/CQu8sCGFVZXRbvHBXL6yGZLTqaFdgw==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cty3j07d2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 23:48:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/weuHNNlSSB8sErSKNmIiWqvj08euUTiAWLmlyTXVieDypi1+oTnfrDT7UePVCPc7Apb+NzXkEmk/DASWh05q6GYoOQ6uXJDlai6hzWJDB1qVPMCnbAeHAtoYS4x+HF9XhU+2O1vS+mhvRCcoEcYgfY2RvCm16xoM/GjnFff6O8fACzoxkQ/KyZwPSEOOTHYR5udgS5NFwc8z+gbtQq4+A+OQxyib85c1KQupziJygY1eQmobHBAWCzBRzvf1qCU5vNLOuo/wyjuDBoR2iK20BercXI3qAw4u2e53i3vn9ASYFhVIckuif2NETnGvu5EWSavevIAK5KnQ7XqmJy+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7PzvfpKVJTg13vUI/SvpUnyNoNw/BDIxVNKRNdIMU0=;
 b=a6Ir8nwEfRGii0CVD+qpy2sRfUBIDb97DqAGUVSOcMut5ErW8Z+EkFSEV5ffqMNOuNYwCqjqXG0EDmIObF0HQHQUcc3398kRpV+7Q6U0lpXQ7FNuEFeHfmgwNptB0CYaY2qUcsP4EgRHfEVCK3GAPClBpi6zfL8PQ6cmaeuxlEub4JTciXtBGYitfDl4L6oIcblgqPbJ+A3/E+wq3Nfk+G7j3CoO6QTUdrNdnkeDo0WK9MpopjAX6xVCoKMJjb73X9BwrroBrVwwPyc/+f/totAfGWQedXNZrm86/tIERyEhhn1pvlSmaCsNVKF4T0AF9yuCRk+UAjmwNFrzi8Bd7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SJ0PR11MB4974.namprd11.prod.outlook.com (2603:10b6:a03:2d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 06:48:28 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 06:48:28 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH V2 01/12] upgrade-helper.py: remove unused self.poky_git settings
Date: Wed, 11 Mar 2026 14:48:02 +0800
Message-Id: <20260311064813.619683-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0181.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::7) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|SJ0PR11MB4974:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b6d20f-bb26-4cbd-b20b-08de7f3a3368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	xV42gLNruD/hEtvOadjcd6Ae9yWkEgnFr9nf/kISfW+5LYOekWc6aH7r1d+Ul7+OThtMQWCglDyv4C/HmNEAkehyziIA4qlAFMNqXTfr0mxBu698dP0TjhUyKYhOja5Wliywjoxwe8/SfgeEuGrltp1qf0SdL04Ao2Tr6bw4oXtktHyrkUubx/abQBR/tI7pvglupT1NcDNpid57ZpAz5iMCsFJZVFd35wg+6M91yfsyBIgqUt7Qr3N9sR98TT+ymi6T4ulzaHpAgAwFX2shIKAVpIUjNdAmOJ41Fj7LAGOIFdwYksVwwb5n05bE/OfbNbuTajHA7tfnEhsdH8l0FojLpnL65lHxAreMzrTaY83h7652Aen9GVKNLQt10tlBKCpL0VdDKrige/OVdVVeUgPd2MYb+YFPtQ2wSOr6HYeji9eMr2v9YLyUZ+guIYRLzktHW83Uw42b2hTvBnOInv6lpmbfZFrDCMRHJlgYplFCNca1vYA6dyr84bhlQGTMzHVwbrnyv/tYoOOxcI7m5jS03aq+cQKxHQwOzxuyEiPlEbOXRfLsEmPZgEc197Ba67E4i4bR5+vxy8NT6ffa6XElMH53oX4YrFMAbp5x253L0jMyw4RM0Qh6EMYB0mGyR2JVft+Tx7PJG5razvgSz/shI94QJRDPF1emZ5P3u6JdgUnjf8OgQR5CIqBgakxQXvg9MMosPJKdac9G7MdOZDXgwIhAjlCjgA09gsR7CLPy3nwd1Qt+IP3UsWGWaldUaXVd6b+jK/ov/FFXYworJBXuH2j7BwRSr5vkejw63hE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QpxTh2MM/++WoELeQaiM26Ivo9r27JqZOfliCpGtAUamkHGPvW9K70meHuKt?=
 =?us-ascii?Q?ELKeQ261n05ZJBtigM/l+9h+JDn1FbedhdWkOtCCUg8EOc+HNhIPo2rHXHuz?=
 =?us-ascii?Q?0XtYSfhX2yW3L7ktgIoj7SL8YrWdGxn7lX0dRvTaW/pMi/g6OkMRVC0jwoYv?=
 =?us-ascii?Q?qf+ky6nrXjjp8pIKtKhJbtu6/h/R08zn6XRQScJvbw8+KLH3WzrlpOhB4CBS?=
 =?us-ascii?Q?KeF7oW/zxYMP4FHFqDbkZjHEDHlfbHuYOdRE+D9sLa8ST6OK2ItefUmc36C5?=
 =?us-ascii?Q?Fjlyr7PyUnndO5ug9qZpjti1Miw/xbqMVA1drX7DY8QelH0+ctUNlhYNQeg4?=
 =?us-ascii?Q?Cx4s951bD8Lq0Td9DvPGzHwMwXacG70VFLKiTzNCXsgZB+BYAsVhvF8hzP2r?=
 =?us-ascii?Q?kY4LQiNYAAe/l5MpWw/C3I0GvDc6M2GivTtClSLox7Cu4UhYVRVIih8BtPXz?=
 =?us-ascii?Q?PYmdtlyU2AgrdlRy/xKxvi3qZcFAFW3u9uVqPBT1bzXUwlUmx6qsMHfa2kq/?=
 =?us-ascii?Q?ztGwieefIGMob+DlI+hMghoUsZJU2UWpaPRUMQJV9vYEG9i7hMpKRlRsP2Y9?=
 =?us-ascii?Q?C/v7VcpMy5c7ho8uTqR22s5sLRmv9bVGArTj9foAnISTkfh79zhI0w+3+n46?=
 =?us-ascii?Q?bTHG0CDin28szXVqx9BL10duhcP91+U1f18yXJWFR45nV8mKju7HxTLfVNeW?=
 =?us-ascii?Q?yuVDwVQ8LTM2uozbzM7pEAyyyy+6Ah6fRFwRVSgkUU9ODLDVoa0qhQjzIehO?=
 =?us-ascii?Q?sOs8UjfhfbPq9KUFXm8oD5O4cxm8Tc4RwJ0DrmhneJByQgFLbK8swSTehj9d?=
 =?us-ascii?Q?86PljQNvGwrLhZIhqAPZi7F+YDfmi0uQnyNNA+qaWpuxDw9FCVqmdBxKu/qP?=
 =?us-ascii?Q?Dj1BXsMfeSkX4JQUM2SrpyV8M5ANuU928ko5bLNFownsjbdgnLSrxOELyztt?=
 =?us-ascii?Q?cOd9iIXebVs414Wf0bgmlmev8T9rWjURdhJKR3ct6Y+Tof6MmNeQwhYohASx?=
 =?us-ascii?Q?MHveV5fmuNKf2UJ+YpU/pkuDUL6kElaMPOkvYhb54qKPETy900FdxeXyepBY?=
 =?us-ascii?Q?YSWUImV2L0rg35tkvsThR+zko796xLh1xreV0DVlAO5Al4Xbt+5rRxSckmo1?=
 =?us-ascii?Q?DWOagtUHOC1YksVdqQzJkN+99XJjDZdukqp7zd3K5klFc4a6BAj2b+eTA9u2?=
 =?us-ascii?Q?4cZRlkLAfu4xn9uGk2XY9BWpG678crL7Dm6xPcw4d5BnVQUuZ7zeTeLExWYy?=
 =?us-ascii?Q?lEsBSmZSkeM4JGEUIeF8mfcVOYqLduxLqh6KhOIDGKNJqn5gux8VCAXWn0tr?=
 =?us-ascii?Q?TuxF+eHDDEJDm9zjtuaQyUcIJEMxt5wtUr5tj8LiM7wPl2OoSVVoaKTXphiT?=
 =?us-ascii?Q?CZ9LRATSV8MQPsVerN/QN8kOISxGi05gxlvrracPlN84a4U8yzMhPJqTwLpv?=
 =?us-ascii?Q?t4xZdpgEdZQEAMHTT0cE2MgziaFkHkMJ0CCRtr3Y9HJHYUlKnX9Ln2/VefY4?=
 =?us-ascii?Q?cJ5JIa5ShppIxzCQf0HnMzLfNAP91F2ha96u/jEvri4aPuzdXXFarbc3jFvE?=
 =?us-ascii?Q?HadhuuqLP1TIdcnhX/AWbmI2+loQkNWql370o1BRvpuM1a7Iz75yFipDPfLC?=
 =?us-ascii?Q?8rAokEa28djIjvMwjsdncsC/rX6aDNl9AQSyjp2qphDCDLq3y7+nRKTT9ZD/?=
 =?us-ascii?Q?WDhVX5L0n7ZD4R2/yPIBhO+KSMlschsLCpMvjubgO4eprPjT6mVHCNXPxMXU?=
 =?us-ascii?Q?AGCr7j9D4w=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	tsZnzw2YgjjhTQ9HLcJhHlod7lsVlJY8XU0191tNjYiMq3AQWnu6Bg4rGDyJeDqgcOAKPhFGkVddE2DZj/uOv08ShVft38AMrhl3d/sNlMMrL/K00K+hPzjDUsMgCO22VX5THXgNwrCZCSjzqTQ9klrwltS1E/OcwUUIQslmI4SizW4nvKYKV8fB2DHCGib92sWhMawJ3xWJTXtKTCt0/7gTwkl+kttwJQrk1cyTCTuUAMfnpBh/YcNEpl2fFtxeCCJ3sgZ62YJd52NKKhX8B1mzXZj+/D1rd0BD6WURalC0S8j51l04aFRsjE/pInHwsW9KVSppYWbnZ15vuBtGPQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b6d20f-bb26-4cbd-b20b-08de7f3a3368
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:48:28.3318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQ2dgfu9V1EMhktVPnaKdYAUymeA9b+PZmpFVGjcur+07wOcWz4W/jYphdLsHFPdxjRCSO2VsUPG/0wa9y7tWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4974
X-Proofpoint-GUID: 9i0cGtP9SufNeQxEDZrne6uhFjUqM6sP
X-Proofpoint-ORIG-GUID: 9i0cGtP9SufNeQxEDZrne6uhFjUqM6sP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1NiBTYWx0ZWRfXwOid/uEeeU1E
 uxjC+qVsFNIxzgzOHtYqtsOP7PKz6JYT5WLyFRGo6InyWdB0VGmbFIgfJsUXItbjwMSzvixHuAz
 rCOVQPclGLFaASRAGRg46QHxm/Fwy5spCxfNz+3zBIy7/aJxBH1cJp+prNFxK9Eh4e+ZgINWjVa
 VfzbvGhBRJy/1fIweb8tvdjwhatkLXOlZODG6Q7am48p4FvpiuNaxlXIPrumD52QDyTbG6GqVar
 Tqg/84kH49CARJ7WCeiMdhboHgOz3MRsDKYBBBDfOmPVDtJKOVwSzTvSX3yhc8WpwZgELGcLAz9
 4z4OmrRJ7jSkE0CfK/7Vo7geK6FCs+jXCkEhd8fETamgkQoYf1SRmn3qWAgD+lcAqfCLOIKCGn4
 5KFyKYhcL6U4hwtQa7JEnCIFjv/vCpvXFGfA6mRG2qCpiU9c2gh/qMV92gruPqD/IrD+VNj7ikJ
 smZxFxd6r1ZNwDI50jw==
X-Authority-Analysis: v=2.4 cv=Qr1THFyd c=1 sm=1 tr=0 ts=69b1103f cx=c_pps
 a=23BBZRleo/1KOgyGqX6yRw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=yuVxGOc7aRE3UmWQ7QUA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110056
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 06:48:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3415

From: Chen Qi <Qi.Chen@windriver.com>

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 upgrade-helper.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 2f38e0a..3b98f7c 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -184,11 +184,9 @@ class Updater(object):
                     _layer_settings_error(s)
 
             self.git = Git(self.opts['layer_dir'])
-            self.poky_git = Git(os.path.dirname(os.getenv('PATH', False).split(':')[0]))
         else:
             # XXX: assume that the poky directory is the first entry in the PATH
             self.git = Git(os.path.dirname(os.getenv('PATH', False).split(':')[0]))
-            self.poky_git = None
         self.opts['machines'] = settings.get('machines', 'qemux86-64 qemuarm_musl').split()
 
         self.opts['send_email'] = self.args.send_emails
-- 
2.34.1



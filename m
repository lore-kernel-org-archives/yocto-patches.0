Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B510FD063E
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 06:48:48 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14797.1773211719207448065
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 23:48:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=de4a7cSY;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7530ed8fe6=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B4uAli2750338;
	Tue, 10 Mar 2026 23:48:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=bFZc5xJ/TvTV8AhL45TFCAR6bz2x6rUZ2aoXODq9lVU=; b=
	de4a7cSYIZFwtYDJrDr6TYciQTiMXCDyIylxUOr929fQFL4SyiYo7MxeGDD1+zGZ
	+vJQZPk6oJ2FT0BejWtOwOeAAkbQGlqQkR1V+W4CInkEDtO8dxhpbOs7e+3GqFGY
	J9H/YaKKW/RtNo4AIt1sBXywVAmcySsCjo3jGy0N7GYokzF5N9hQWV7lkTXfuZhj
	IqJrKZQvX8pqAFbPdiF9yKNqK00DHxrOn/C0ejsnO6gw8rXSp0E34Maw8BErWO8n
	tmGKebfSX0I9CE2FLKqad/Rp+5W6cbcFbelK4+/37juEBOABKhwbCnG5ePvWEWEp
	PdJU5T5C/mjinNGw6JZpgg==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cty3j07d9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 23:48:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CM/cioOGbHmiStb35npv9QhKdQrTWiTY1t9uGpwTbIoVg4hFzcNXJH/D5y+25KYIQE4ACwx8fU0FynNexxZDAzteWeUZVwmyCsCLOxgRu5enI9FIThpDTusT5Fz+I3yceGy2q2gWOjWXhtVFTMdxYdmUYSnuw4h+KKXOOtNW+sn/E2zDXVFjn5iAvDoa21sG8OUHspn7PObnYVSouvlsWJqz5pyIIbsusGMUC4rcrMifBMyNxbR/6qS5Dv06pBiOEkyVBjAVqF7isgOHvm0w6xG48UNXYsf88lLY5kzZ3b6GkLE+kD/Ylx8As/jxIR69bJpzXbQMoAUMybFQbLYsOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFZc5xJ/TvTV8AhL45TFCAR6bz2x6rUZ2aoXODq9lVU=;
 b=Shs9tk8hcSGtVnfZuqMm+DvJ+rh+stsL6WZ7mogynv/9PWSRl5oM4PlMMaBpT2IxZFMEwa4oXJT3DL+oa5vUP6rMOF+50wUrx/8GgRVnfZ63Ar2ijE77hwY3+13q1vK+ruk8+KI8Kw9qjHTej/4OsGRhOpEMAAnDp86q9qOm6/MhMPTdUKPWHc30eXU1ugsef2rXMlZJAl7PWqMKLv/WumIbedtRKhqDu8V3oGGSIv8iWmDv5nCxpR3Cdoh6nUfIDRVVmdnMZg/IL/AVdauh1+gQLtR7JJ1F9nLLpqnifbvc7ndw7vbl5XkDpX/pGO6lRizpROkcObXkpAfi3hVFDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SJ0PR11MB4974.namprd11.prod.outlook.com (2603:10b6:a03:2d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 06:48:36 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 06:48:36 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH V2 06/12] modules/utils/git.py: include repo_dir information in the raised exception
Date: Wed, 11 Mar 2026 14:48:07 +0800
Message-Id: <20260311064813.619683-6-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311064813.619683-1-Qi.Chen@windriver.com>
References: <20260311064813.619683-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0181.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::7) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|SJ0PR11MB4974:EE_
X-MS-Office365-Filtering-Correlation-Id: eddae022-509c-43db-213d-08de7f3a3817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	v6MvbE2dHGH1sKUmilLvH5RMH01HY+o6ifnvEOBiE1TbTO8vHQtNaa+d7UYnaRM+CXzbUUQA0/K8WHnB/0fNbNl4uYXRSbXPujZBQRe0JvX/qB4UpU9Bo6BHbZasPwimOw/VERbd/2HUSj4ob2WF+xAapHv7iP1XRhRmgcOHbcPOQfOOXnOWGfbdU7QaRCIYJmO9NV7LyrFTKt4T9an5rkrhkZcdJ0M0wVduzBU1LoV/JvUtM1qKUr3ysTHR8siRMBwvs2ju4Zqnq8AAXTKJ86iYyVWao7WVqq7j3blKHpZOMF3qi9Cf27kDq1gjz8BsDby2k8uNmjucRIHVfkC5G/Bf7q6LcGXXWKFKirnJEIfgyHROP0ojfO2QwCrNYP0DTE0PxWwYzBhfkyfUQyRf5foEMr0Uen9Ku9+f2Vf/WSqXH8B9AW06+iWWqZpVSwB3EMmqXXWXhoywKCUqcFh7wF0XqWXLaXzF/4vjzevd5mj2E41LXkB3mk43tDHt927TcSZ0d3FGok2P3SrvpyXTKrTVK6vq9RD6dZd7aXQRsOC/KLv1MAWchIGLB3T1I3UAtHRG0CwuAK6TqB8XmFP8lslvlstrJZInQmKqsmhAD1cRpjEKApRggTHjRk87NL47QZk0gTghQ1Gl6p3CVy5knwI3V8LstRFwJi2GMVwlfohjTKpv9fTU+AuiJIwllGKukcHUFbZNpBdfi0i8mRkjxmGOoaIVfQ+H8CsghNs3a+pmMJyoT51d53KCbkierHvxuZbzCcgMV2p/T94lL+tZvwVC4prHGT8psWlsh7QQ99A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VW4R+VIKI5uq/KHSrxGK3nVSaxJl7o0v4qGZ+QXSdzLuRTAws9JUy6ECSFc0?=
 =?us-ascii?Q?qJsWChLFmoH5jnQY1bTaGe270FBCyKfiSbG13SKRdIZ/2b5NPcyZEwablSux?=
 =?us-ascii?Q?762n0ZYk4X0lIz/o/vs9+n8eOPpQrF9NbHdv/h+EGket53Q4IdM3vQRqDRUS?=
 =?us-ascii?Q?eU6LlvX4yNm0UODKxeIKlBTaXUZK4y3DmKx8N0J1dP7SE4zm9reNrRQroSFg?=
 =?us-ascii?Q?1LYBMSMJxri+ovczb5LlITxUSbXrP3ab5yUoj3XLUVpi1MNS84Y8k+bcKvj/?=
 =?us-ascii?Q?EDzdPKlUyMTXj8EV/3nv18hVKs7AF1L7hEwgHBSvP+X6Qwd79lRD19CMO/O5?=
 =?us-ascii?Q?ipsxmUsdL2C9zT0yGjbWneeKS4zNW3GR0vq3CVgPLO9/sQVk7bbjltCnCkcq?=
 =?us-ascii?Q?XJWRePW2QsixGrqpziejp71XlNZE0ExjlEqWDA0JRmFVCmmQAIVJvTqwhwLO?=
 =?us-ascii?Q?VnZEWt6eRwPuTx1uVxOggne+w28f3HnZ8F23h+v9TGIFhFqEHWAu56oxs70e?=
 =?us-ascii?Q?5Gls/HF9WXH9LUtDQKVYteyKZchUnd+8Hfspa5cO0dl7ydmxuk8sNLCfcmIK?=
 =?us-ascii?Q?ofMyr9R3tZVSmVij2B/hAizatr36FgJDgZzURvEhmYfqevxtHuO+0GXTCUmS?=
 =?us-ascii?Q?TU+GxqHAhn85+GSStb0LZusYQQ2qFeNcKVmELO15jMrlp7bd8wiyCM1NiHB5?=
 =?us-ascii?Q?/nn9gUC1tlo8OEhZKEfUWfExtwTWsaYbvXTN7cSh4H5kRaBNfs85FxpuDZuy?=
 =?us-ascii?Q?R34/dKpG/oj2qsvJgNn3gignH+2u52afKpz8kH6rAutryfzDakYmua+SDv1v?=
 =?us-ascii?Q?xtm0o6KcPsST4WuClVi4Gf+nAHqc8iNmAP49fUveGQGakpJrmSaTJfb7Wksw?=
 =?us-ascii?Q?Nr6TPDwCovEXtl+s8OWzOxNZBWOcO+6ShdDboLxtddZeM4rCPYzhyMpxQl4X?=
 =?us-ascii?Q?Lzpjk24C10120gbKDPplDK9gjsDVLnl9wphxH2WbRwOSxVmprfuHTabeRcrF?=
 =?us-ascii?Q?MGpH8i+PPxeNIKe3iuZfkwR4THQwtMpWcwwsR2YL3XyF3B8M9f10yV/cydZk?=
 =?us-ascii?Q?LtXHZBBrqCGOEDdjz3AzLs901k5w2gGBjXj+J9zsty0AEhj1mP8P5STYuCc4?=
 =?us-ascii?Q?BCtAXdLyI8BM50xiEYIlVF2L24+9rzEBwtDXa5lodZW7I+nyC3kvQLxdiS+x?=
 =?us-ascii?Q?1ck3fHb6NlH8CcLdZjhJS6tmJ8Zjqg6WoEkknvWcMfCVj9ar8ksqK93AwUfq?=
 =?us-ascii?Q?5yJh2hg6eOQjGvJOIHh5pHAUJo8zm/anhLwvwDacBz9eLXsewf93oVzfWvk5?=
 =?us-ascii?Q?ODvg/1gZbSH39LOzkNgqdGgaTRRKOM93ynFxLrCOwgN+up746vf5GSbK7Ksk?=
 =?us-ascii?Q?ZQcRPM9RabsNK534qg/EaeSKHJ6qsHYcAtrqnE00EnmVz718ZWySVpaMH94h?=
 =?us-ascii?Q?5jyAnvypx5tYs1XYrTdwXAYtgvwI+82L8ITpqVM0juVHSaF2E9+2YzYVq7Gh?=
 =?us-ascii?Q?YB4xnpcdIGzRWD0N11xif+zjRhhAJS75x1+JRDG40h5xhdb5xzfsHVRRn8fc?=
 =?us-ascii?Q?REfjqGziCAaporRfobjMylSr/zpF14H3pg5IWd94P4JizV7gM0tgjfDs5at9?=
 =?us-ascii?Q?q4cLVSLIi+SN/So8ufFx8Zfyd6mbRewDBoDoU4Rvl84DxSn4YO6pF0k3tVNJ?=
 =?us-ascii?Q?T3qlZB41d5Rc2F+x/nYikcwuCcysgOyGQm6FKJQXxjcIKx3uFMAlhElB/PGw?=
 =?us-ascii?Q?zodQ51Ss0Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	QN/dXN5/ZjZTvME+7tDm/mtf8cfnCeojN+FiSdOZ8ikpIoy9trMW/FWBZlsAuNR84YPL9NB16nXLKEI1zppp7ajJk1kT0Qp8pSfKhAoczMl4UzW7otLxeIeLsM00V6N0+jACN7HeSYXam/tvofKOpEQH+OSZPw5kVsd0ba2IRwO7+ater7cqlszw6U2YWRhw5UEYayHOQ21LoPJOt/DuCltvuokuZmE7JR4z6jWKQ3wi3114wRHpjlInVTGbzrt8i9/Bqj9/mqKk1fldQ34FUW4WF7aY36e1Oflq1fIkPAho+ujNJ9HCaeIDJLYmiwDSeGqWwDMPhQmSIcwMT/j9+w==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eddae022-509c-43db-213d-08de7f3a3817
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:48:36.1625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KpcqI6fJzoD9zs1ARht1Wt0eA5kT1itr32D4A117iVVL9DLPH29drQYefDgIvLpYS86VZiperx1FfnBSVtFl1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4974
X-Proofpoint-GUID: IAGJ4lOAJ4mzXvB8wD9xJYurvCHPQbMb
X-Proofpoint-ORIG-GUID: IAGJ4lOAJ4mzXvB8wD9xJYurvCHPQbMb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1NiBTYWx0ZWRfX77uQd+9PzRYw
 ulxIce0tj/E9kjV8ZiX1OTzOJA7h7FKj3bGbh5nbceBHT3+QamJdJaJ2esjZvlUNuiZheSK7lGi
 oJfClcV45ukaez0PihiX7I/TbGAvOAajodt7Bdx+2OL4JoIN5uwXEqzUkpLubimNTZ3lIiPbt9F
 aNVdGA2G+03afP03jYY6HgUYcDK3QtJkFpCfaZfLXAKV1ArUmNeg8DdVoa8kezmaNsdtl943jvN
 0ORL9s80FhdA18sJY9HOPXDirPmj0vxKHnaLcYq0D9kk8vgBPQ8pKLJ96C9U0nCMmZaf5Drg3wV
 a3CDepVDIYs5VYO+IfYp4zoo7m/E7MUW9n980YTQNAp16fRD+GCkcEFsClmBS8sT8XrO84DzgpX
 SqHeKkxHjHjhYGArB7jQpnBzxrxzuU/j1BWfrov8EjqhZNQ/VQR4/Cdx8woupMYfZ3CXW2bmTUG
 qGrf+q70c7P52ye+4FA==
X-Authority-Analysis: v=2.4 cv=Qr1THFyd c=1 sm=1 tr=0 ts=69b11046 cx=c_pps
 a=f/vGOH3Q9iIJglbWlzIglQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=jz8R8Z8616863Q2mrucA:9 a=FdTzh2GWekK77mhwV6Dw:22
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
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 06:48:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3419

From: Chen Qi <Qi.Chen@windriver.com>

This help people know where the git command is actually executed.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 modules/utils/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules/utils/git.py b/modules/utils/git.py
index b504ab0..38c6a72 100644
--- a/modules/utils/git.py
+++ b/modules/utils/git.py
@@ -41,7 +41,7 @@ class Git(object):
             stdout, stderr = bb.process.run(cmd)
         except bb.process.ExecutionError as e:
             W("%s executed from %s returned:\n%s" % (cmd, self.repo_dir, e.__str__()))
-            raise Error("The following git command failed: " + operation,
+            raise Error("The following git command failed in %s: %s" % (self.repo_dir, operation),
                         e.stdout, e.stderr)
 
         return stdout
-- 
2.34.1



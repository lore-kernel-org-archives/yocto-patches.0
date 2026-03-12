Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5413FED2D1
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 03:52:54 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13957.1773287565619874843
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Mar 2026 20:52:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=tFTxJUkR;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75310a015d=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C3pA0l2877391;
	Thu, 12 Mar 2026 03:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=cxJ9oxqnior0K1cEt83LNPz4J4BVTNJFPZiyFgkp/CQ=; b=
	tFTxJUkRlT+MOUXhnYGlkgnlFXv0aNXoSq+ZCpZFfHi5fI1OjXkTXlMKwKiv94V1
	V249ivqO7jD7N25/5fzufn4hUhZsfil7JeaopD5IRVgX0cIYiZ4lOxsvZIAmPjbw
	FheSO75VoH7Kmzwe/HTglUWDkEnE3Nx6k2xSlsFNA7OFEiT0dcj5xuf6eIYYE9bi
	fgNKqj+ZGBCBG7oprvuERDeyNxhmaqDLGDTT4In0CLYRqKuxNY/obvvHkXs3ujrq
	Tar/A+VEZHc5JKGDtXNEBINLND7mBszRHdXJzHGe4cJwquSet8EpUwXiGogOMjOO
	iiGo2QqO9yf5drHOWN0z1g==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cuh78g75x-5
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 03:52:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMS9xQI1JNN8qUaOi20cbsAv/q08RP+yRvIA+PsJ7+IUWDIQgbOP2NLujC6grYfUHEF6AIHn3dFCmSDmGuuABXf+2rSuTdGkSKhUIWFJuQr8qAd6bqJ45kVqWdg7DxSPNrMXG3Unr6Blw4cZ4JiSrLsAnPG9hdKyGd4aT8uSxm53b8LYFFl8rjyd6VVaBIw7avINR1z6TFGkuApKjDJQvkAWDDHjn/oP+H6+UEL1CIxVg2yhO4Rxju3ktr+aeTMZ3+D0AQWSiCrieLe281JJus9RLGssrK/gXHy82Gkqso72+og62CvA5RnFIslkCJgymBU5KBXYD/PtDKka1YXgCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxJ9oxqnior0K1cEt83LNPz4J4BVTNJFPZiyFgkp/CQ=;
 b=dJbScJFB14fKMIXg50qcGaR7ibJDoedkEG/noi3YmmjZzrpgDmDUDSZ54tnpTqS1VRMy06+Kn7VMny8TtsnauULFQ3CkRHH2inD/aaZroLRpnnLRieg9ewRTEqvXP0jNoR+y77C3jTGo+dhr1UP0ofmIFV83p9gPaDNad6MBAVuQk1kSkRVeVRvOV+eNGOMb7bRxR1b1hErM86pGzt7kp1PtkCkRs8AdpUN5yjaXoyhHknQV6RfUThvGuOvnc2o1kiuWMxw0rJy2wIGNfP4ixz0vf6ZAogVx7fTJLKAO2t/pEv/XlGDnMeypwVShHuCve41XnsUDNcrT0JdQ1o3UkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB7942.namprd11.prod.outlook.com (2603:10b6:208:3fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 03:52:37 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Thu, 12 Mar 2026
 03:52:37 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH V3 06/11] upgrade-helper.py: fix exception handling for commit_changes
Date: Thu, 12 Mar 2026 11:52:06 +0800
Message-Id: <20260312035211.745546-6-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312035211.745546-1-Qi.Chen@windriver.com>
References: <20260312035211.745546-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0021.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::8) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|IA1PR11MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: d6540697-04d3-49b6-8820-08de7feacd0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	u1HWlzov0kpxoYd/Jkx/py082g2i0JSy87CouoEqnm6CXvuPNOB0F5qCdQOvo/uzft/sjAXiD9Im8tUiYTMkx8eiGtrrZOfkoplByLG1X6qCisGTLziVhJIZllS9B9HRybA33Ya4mS3z/MhMdCt8JL6/bmudd5U2cyqE2+kOTjaFZW1WtCI4FFem0nROnMLW86DJEa9aVLYO2qPlQJxn+nIPUKVCufAlYz6AtRH22pt14NFk7bYEKaBWU+2wcf9gkgjQEZNO6pXxrw3mKxVX1VzZeISgoPfHZCi0Cv/qbPX6/bP8GcJOM02Er6iyP6yS6NqcYfBhD+Tao3jCjnMEp7IPNIK0Pzhze4vTXOZosCb6e7R21erthyKeidr2IpJCzobP4QwpiR646XBHjj13eoRZ2CVVzj6vBUXAo6Js03hXkLcsyYw6AaNO0KeDVBhJ2kmWmgwe42+pXB61eoRqpflqlkCVtUwf0sM4cNg75ploUXbxiD6mwl6KCysP+ZAPHkHlyxMJvbWC4c6MeNwz7Dx26NvDbDrm//7bh1aM7CRX6Cbf+GMqnWT71P9ZPi7GjsK9o4OFZAiwFi0zZIQ8wKZ8/Ek0Pe8qqzIEUwIy0idX3oK00Wi6I0TFK0Rms4yNN0mQ3E5bA/3sN4onXCmvItaqR+RCu+nwxlwRVs10Y5L3TgTKA0Fr6x4ir8wGxGNHWwtG/+HdRPG4xIquCaqTEmDgqxbTbCf3lg9WvcuLz7sC8Nz0Gaqoj4txs9YN1msoRsyhPysPSYt4E6C+IkoJh9rXEO6qRGMA6oVqbZdlKv4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FuKlO+BqznZRaA+tYJPpPfSE3+qPGO2cv0pKWzhhuNb4Gh090BlsDi+FFERH?=
 =?us-ascii?Q?r7DCn63xAtEfWKrESj8wdAFDFSJzzpLcJsGuTbSjaPdWhiIwtGKj4x0YCVM9?=
 =?us-ascii?Q?Sl42+V2bl3ZrBHVhIki+psty74lBho80LR40oKgS7dvpUAzSfy9ZmEHRacLe?=
 =?us-ascii?Q?scyLqImyFYiMPcFQDop+K1iLF3Tc7S3DHAMFf366+CnP+N068o7zVb1Bk7ll?=
 =?us-ascii?Q?rgMOkKQzJ7X0LZuFHQrRLCm3s4rdwi4EX3Xbda+rBdG4rMQypj5GZK1yzSM+?=
 =?us-ascii?Q?ieqF5wUxkLD1u8I58CQmR7BT9+Ct3hfdmGPcGB5xnNDLUQ73A7fcSS5QDFUp?=
 =?us-ascii?Q?pws/0ol+0S/pDOmqvAHNLdycJW6pYcWgXAWLQ9B05EBtZzxGVaGa5XDvFdbb?=
 =?us-ascii?Q?5a3uqt3dldhujH0Kj2fWu2U2pRmGc+5Bwc/hTeeQM3lEltqGELm946DE+CLg?=
 =?us-ascii?Q?xZtuMNSV51W6rOwx2O1f76qZzXjL6BFQIt5u6hHV6FNtsP8+tpaJHTKbmdlx?=
 =?us-ascii?Q?LfhJyXy4Ouw+UocvxJRyL75A1cE/UfnjmIJb956i4U+lSa4pg6lV6tC8LgEL?=
 =?us-ascii?Q?UC03MOrXFCKLnFZTAjzG36GP8nPWGsM+4BNkaUdHwjiD2leSfjEwOjhWDpBd?=
 =?us-ascii?Q?/9xyI3JbtDNjPm1bk5kadrBDOaNjxt8OGJ1qsHrakhV+Cg8s2t0kA0hEO6pL?=
 =?us-ascii?Q?FstnyrpHyYC46nOXk2Pese6RmyN/eWfjsO4JBDEiXPVucTN+6nT0BlpQlS3C?=
 =?us-ascii?Q?BHSAL3ekY5zCbJ3GYBKHWUPxFfa9R3JyHb5OcnuKuI21IA+/r+cHyevjbjBe?=
 =?us-ascii?Q?EBvDTmkifKzOCq/jKQ95iTVqYgS16RoN8D7iy/bjyE4uO58u8pGIS2aSKIOo?=
 =?us-ascii?Q?BoKh5guB/zywxo19cZy0EuEt1LdEDri+LVu+fAmTfxxlGB1Fo3tZgrT/DsJz?=
 =?us-ascii?Q?gOq2T0lwOzFnOPesKiVhjAnijxM6EliEsFOblRLLac4ugXN5D2uDLYd5sMX0?=
 =?us-ascii?Q?xF3GB69XtVQgfqxGAXY/UBzNFF8EiFjj5R4pOmVXxbSCyvacTM7iXq6uqti6?=
 =?us-ascii?Q?MNPId2iTNh5AYlJNDlCRUGcY/2q4MrP6aGxIT2rphcrwE2PsNTQYNm96gyE6?=
 =?us-ascii?Q?COpVRD5f7y5t2YBYX2qkLn2psDl6ESlupIa28z8MueAdNKlHUkfJyMqwEhxo?=
 =?us-ascii?Q?Tows/0qcrfDFKVXh6/5/ygrGTFd95Holj1WPMMos30rPLLA6YTUmtdXX14mX?=
 =?us-ascii?Q?o9h/44mMQsOTmQnoZYItEXvcw8s1EKC6/duQsqeXyeGArgF6jyo/mnByjSdK?=
 =?us-ascii?Q?GPKKWkr6p42/6HCjt5tRngJ5JTMRyOmK3OEpMD9YEDcHdvTjsySt6TvxBYVA?=
 =?us-ascii?Q?T3CjQptZgU+HW9cy5VuQbNW14H79KYA9UxNR0NuWZXg462JExv4RbpBf6k+f?=
 =?us-ascii?Q?GMF2OAHfJgTEPmhxPF/kxgd6/Z2E0hApDlNECQTLcHaHU5aoYue9FZKk5hIZ?=
 =?us-ascii?Q?yxkMHvTJA/QmLUboQwryOs1ygugN9d/FUsjxkZs6pzFUGkKJCIbW9eDACDBV?=
 =?us-ascii?Q?yEa/TgTJqGCDrDtrESg/iBDIXKNXHpGRpIpjwhhlZ0QYJ9WMySmYJhtxvUxm?=
 =?us-ascii?Q?klVN++uQ0/NwYmGmB/5RLmkz0izkNLgXRSZmDvdF3z6YNHxd8qtXXpJAMxtB?=
 =?us-ascii?Q?25fnDqmk5NIBJ2OpzOkld4cKm9oQ7eCqvtpo8pfq4JgcWGMEPs3RdrU3cZXW?=
 =?us-ascii?Q?YW8JmZ92LQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	pGFgf1cXkrEs8ORgcp9Y8w5z23/4AnxMH8BBbLByR8F2tMbHVzuVePcOF7J2yTjHKBqeX6yU8w0Hy2hV2JYxo9MIqzlwkCw9N7CtdRf7lEVRTmJkpTiCHON2RGnNekO/1JbbV8VoyMUxO6TC7/Ekjhc/f1fO+JmT1v/NeZRGj/ihZPM1kJ1srxE6yGd2Znsiu/+SGxM18GQ2s6y/xVvGTgkwDe5SdRV/qwybtbJDYChQdx1TowRQpmiCgCPHXF1ve2m+I1wdDtXFJDmTqYiL7bDy5VJXWUngWHD13PaRri9kZtNRzaZYU6niWwOih+dT8nvARIRsTZrfx3ehwf7Dyg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6540697-04d3-49b6-8820-08de7feacd0e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 03:52:37.4765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCtr+1kiWxsxYI8XBpSvS9GbbTYa9SQkI4geotGlFoSkb07JCxb/fqefVi+Ed2V+5DzzBO+hq5M5KNsnClUPGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7942
X-Authority-Analysis: v=2.4 cv=ALvEU0hV c=1 sm=1 tr=0 ts=69b2388c cx=c_pps
 a=c7CpAOS9Jb82g9OYW51qCA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=XtcnuV78pZwgIC8ia4QA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDAyNyBTYWx0ZWRfX8+8h7CBY8tdc
 ja9IYChbzTQnl4Ihj4huIAPDrWqxtW+4DMCvGLWgpzqFgCsJ6lrmxg41DmCnvIuImfifo1MBw4a
 0XHmQ0cDQHhBk70Gp+G9Ax9YmxlJiezWqManQTa/RfCEGXICvTTBEVfyBWE1y/bZ3AbgDRqmUD3
 3RvnpGLLy6JzsOS69Eu8trRoRx18yf0LNx8ejAiYqZ0/CekjTQasJhfLC3oDFiBpnRzTgxLdGkI
 51J40vXjbF1BPVNgf09L0kEY7TT8LPctCMKpPbMN950VKf6GmgcRivw3r6UruS+Cg8esl3JeZt1
 eeBeMgF0nOI/srrZJe76oAHJ751OIM1hxmNEIvzBaNAF7oQ/YGKas6Qge6J2R5mLo86dmuQIPrq
 P70Z8EYmKnQ0dxB73rUCbWtG8FbvbNf7yWq0XFmT0S1ckUJjEm1BuWSmCE7ovw4K3/yM2mhFmZj
 tIHmXB/LF74cEB33uHg==
X-Proofpoint-ORIG-GUID: qpb_fj8ww_hrlbowvswD9m76GO6YvC7w
X-Proofpoint-GUID: qpb_fj8ww_hrlbowvswD9m76GO6YvC7w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603120027
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Mar 2026 03:52:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3441

From: Chen Qi <Qi.Chen@windriver.com>

The previous exception handling is basically self-contradictory.
It has g['error'] = e below, so it thinks e is of type Error.
But it does not make use of Error's message, stdout and stderr.
And the e could well not be of type Error.

Fix the logic by checking the type of e and handles it differently.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 upgrade-helper.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 27e1f48..428d66f 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -523,8 +523,11 @@ class Updater(object):
             try:
                 self.commit_changes(g)
             except Exception as e:
-                import traceback
-                E(" Couldn't commit changes to %s:\n%s" % (pkggroup_name, traceback.format_exc()))
+                if not isinstance(e, Error):
+                    import traceback
+                    msg = "Failed(unknown error)\n" + traceback.format_exc()
+                    e = Error(message=msg)
+                E(" Couldn't commit changes to %s:\nmessage: %s\nstdout: %s\nstderr: %s" % (pkggroup_name, e.message, e.stdout, e.stderr))
                 # Ensure commit failures are recorded as group errors
                 g['error'] = e
                 if g in succeeded_pkggroups_ctx:
-- 
2.34.1



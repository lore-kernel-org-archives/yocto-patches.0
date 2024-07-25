Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2232EC3DA5D
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 09:05:06 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.32125.1721898303243734678
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Jul 2024 02:05:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=79368292ab=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46P6eVWG016145;
	Thu, 25 Jul 2024 02:05:01 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40kcbtga5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 02:05:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trrUcBo28+7iM+paDvAcHjUcFBV6Vf1VRfOEAIoWn+mu7Rdqx64mYfEutHFTIz5lyfbXErOkIpkKxcmGcxMrSL4CZ5bxq6Ny2T4DogD9tCSQ9+qrKeFV3zaQUYnfmj0y2FQXtToR+CFo5dj8WkfBoLek5H5/3KRWbI4gQYhWSQOjiRzbQWXT99P5H1D8qYY8D60NEoqXSQXtvLmPsZsyoiSz1/JjNIhf8HTk/wJMPCFzaE4SdscSBV0jChCuiLeSs45r/CGO3sKD4Vzc0xc3Y2a1cp6pKLnh8M0P+azIvyMdmyZKJ6Dj6s91cmR0ruyx0dIe5ofRoLn7+2Xzvq93JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNBCSnOHowAWj54vzxP9J6PTexrYyQUmixL/UE4ryh0=;
 b=S4iapBSnY8mdsPZgYWWZvFj2dMrQhGjm9EXkiRmbbQUHuoH9aJOvKOWUPFM/ZjPMmNBI016+sXvMGyuinUqZHKr6jT1i3ijUxgKt1vUJb5UpVvBP6/siyhWzsuwzk72DOynesGL868LVcxVp9vsENFUNRAyeg9qthBywJb98IBZexYw4QWl6s+nyTqe+qy/yAAtXDx21ANedPa/kg1KM2sY5QBhoee6Fy1lR7354oUqI7RBzrmg4hMjoePRXVC/MdoSsvdTtS/Ov5ZEHf73qxAlh5adzXCqwttkuYytqZv0dT50OeIu5zvq5RGgZZ5WHPU3NA2o4TfhP7WHHvfL7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 MW5PR11MB5762.namprd11.prod.outlook.com (2603:10b6:303:196::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 09:04:58 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.7784.016; Thu, 25 Jul 2024
 09:04:58 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, joe@deserted.net,
        joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH V2] shadow: comment out pam_lastlog line in login pam file
Date: Thu, 25 Jul 2024 17:04:49 +0800
Message-Id: <20240725090449.167826-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::15) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|MW5PR11MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: b984600d-a97b-4ade-d28b-08dcac88dbea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Qqu1ve572CtYiWLC+5fV7xLJX3QEKZK0o8dYIQX1gaLpN0W4GJ2a59JmLmQG?=
 =?us-ascii?Q?TjavYz/DPO0o+bTvtwqisEF3sodmaV0ph5JqTLyYr2XwTAWtFFdy7F4rJP93?=
 =?us-ascii?Q?MM3du1mjpMJyzNW3zEwIY/tyHd6ggKHm6Pb+7Dy6GCqOgwIRv3y8M956dBuW?=
 =?us-ascii?Q?VOFBj8MWty44/Mx+DTgYGuSFaSED4DxnTOsemPOYb3DjKxuJFp6K3gSVJV9o?=
 =?us-ascii?Q?GmXSLOEcazXHb7PudUreUHPrq8gx8PKH9YvysrGf8wDsEn7r00L28iDwDB56?=
 =?us-ascii?Q?OtkJ2kp7zzkd8n97S943cB+mSrDC8xgCJObTfANxXvjW5moS8cBQhrW38ZPH?=
 =?us-ascii?Q?tnQW7nB3H+hn+Ll14e2AaAGp59v8WIAzh08sR0r9dIViQ4LKKqkRr1F30Nsj?=
 =?us-ascii?Q?7yrrgSHmNu9j3u2NxxZOcSLbKnHKqi5gGNzpGz76UtoqVQjh8BPD3F4E86Dy?=
 =?us-ascii?Q?WWnkRHdfdllBR0nXzqqzjdeS+Cx5DHZtEKiMHtdQCWoVykcraXAsQKsbCZjN?=
 =?us-ascii?Q?LqYT2EuZAkkoLg9s/Mbkn2ITLiSzx2OzAa02B93D0+jU+Seu4aJ7JNG8d7BG?=
 =?us-ascii?Q?Ab2XVSKtrYaC7nFiQFd63iCNTof3DeC1gf9gxzpbMU9+WcOkDKTLapq/2ljV?=
 =?us-ascii?Q?iD5ADTF/27sCcHjO45pzSFsqsxkXwsy2Z61scLj7k1eXeDmspA1LrwY/6sfj?=
 =?us-ascii?Q?DMXTeMLBmpLtOlB/CnzOwI3aC2YlxYet7itjf9IKVPTXgjq2sU0hb2er6l1d?=
 =?us-ascii?Q?T1xYb8uQwMn7+qDAuqZa7TSzZ6HQ0cM0bNqMfDrz44bsiY9amZJucYbFH7fk?=
 =?us-ascii?Q?Hrezg1Y2Wgqgditit/v8OWYhfA48jDq7zbqEtYLWnPooZvp00k2ly19QV0ju?=
 =?us-ascii?Q?kS5FPhIUwAKaPMwZzS9XbZjJBMDUSGCrtG5WlyGCYpoidokuGbafZ63Zswa/?=
 =?us-ascii?Q?ILxnyawrrC1AbIzDtwiq5u5H+Dsd/cX1af91fHuars7iinapOcS6+ADstPcQ?=
 =?us-ascii?Q?oxNciCXyuDFSNF1hC6cBpTWSFLjI8AoEpznyZtymfSfLXYrQDPdeUqWxVXdo?=
 =?us-ascii?Q?mqFkDn7sYUN2QZi2H1fSQ10Li8VJ5vANwW8WA4Gr0qoY9HS5dojVqnsNd59g?=
 =?us-ascii?Q?I7MYlw0RAjAtCNeg+guyd7LGOf6o1msWfWmiMX4cAqQt9WGamsI8zoe+AyoW?=
 =?us-ascii?Q?aWO7BcmNM0d+bua2Qvh2GRRb4vl1keko3U2yLj0pJfxr/+INmD4pYmIlYA0h?=
 =?us-ascii?Q?yJiy9Ic9peCgGTbQLtQrDBbghHOz7rwzeO4OQ3xk1H8Cmxnci32wCkrToZXW?=
 =?us-ascii?Q?BB+a+EHAAmvZIBky3n+mgTAhBz1DlXZ9mJNck7TELxSKNtNH3XW9F9I9m8zR?=
 =?us-ascii?Q?uYV3dyU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2Y3pojPPCVNvwsQ+d3dU7SsaknlCu/04WzZewSQVxraKI+PW+rdg9zvKaQg+?=
 =?us-ascii?Q?eBwTpiIjhfvJSt2hD4vURG0OMFtIupzPBwfuN2fkr2Kd3OfwFuP0odXN7Dma?=
 =?us-ascii?Q?SG7tDB2z3Yv2w7qcd8cZXP2RsBZOgBGjGrz7cp7e+hI8v4kZI71FcTbTUFTQ?=
 =?us-ascii?Q?0ExUhMT6EqSciwvXvpzhUZBtGgVilRgqLJoE7UbyeW7RF7WkJtLJFIUeT2Ms?=
 =?us-ascii?Q?feLvBRz0bzknN8mH3lQwrnIyyh1dSdu9/sLfPmBHqY/qssbOZGpPY44/+IFd?=
 =?us-ascii?Q?A+ooRGFuAHZnqqc4RaR1Z63Jq3XRTaobGUfYV6EleXF9KRyoNBFP+IoPA+UX?=
 =?us-ascii?Q?YmOjjiCXmbag+o5OcUBT2t3wLMbU4v6cOhay8Crs/2avQiFf4c8ycaxBtDGE?=
 =?us-ascii?Q?T5JYVKeUT+FqSzRPggyCN3mFj7EQgHhSc4vwyqBt1pnDJs9EqaQ3g0Lhd1cr?=
 =?us-ascii?Q?DzAjGDH1UHWwQUlYUj0AK6i+rEjo8OtQpXHEmsjmpyCrlFHFqE1ruNBbNsNh?=
 =?us-ascii?Q?7B/EKXqxdbSgxcvIkA6dPcbYDWyjoDFpkSFddBygGfZ12L8NkW/SS9g9jgtM?=
 =?us-ascii?Q?xPhmETDf52nfUekKNlSdl021OQQPfqGR5J/PEyBIntxxVHql0MES+eEGrFli?=
 =?us-ascii?Q?odd3xJJQfS/o+mRNwK2Wd7hjBUCkPiPDVN+rGxU30ZPKJ14rfdQ4OBcFsar1?=
 =?us-ascii?Q?DHKxENaAmRW9KhjfMkdDqwMdqH/VSSZVamKhpLb+AnyQIaSuSjPxZhoYS5Ya?=
 =?us-ascii?Q?6pXQJmQ0P//M58sWRKKHfgYq6apBCIXH5xX/GDp7lxCnThYGqwWLpozQdq+d?=
 =?us-ascii?Q?IFxKiWDEmOMc8UpGe6P/Gr+7O1taQw4Ag1talOyz6CQzTQOY2Gv0CbflpTwH?=
 =?us-ascii?Q?d2800rCz9agjp4VLfiO5ERsrAgkQHgA5nbOwqvT6Qp4adXA84TcDNLuW+sfj?=
 =?us-ascii?Q?NrihW6t5WcZUUfFIe79R1km6+2s+GHDHafAU1Tem78a7iyDKJR7r3p3FXmKC?=
 =?us-ascii?Q?WNaIFBRuqm9Y4suHS1hidUKEmKnzC25k3YSMU83UMlinDa6/c1EiGdywIyoK?=
 =?us-ascii?Q?+n1JxIFBdx5vpxWdV39TFjOwIeOR9fTUa8YFY0GPV4r0r+H0GqAPm9dNptbK?=
 =?us-ascii?Q?Y/eBFiDYUllEiAnUkxX/cUDwtWXqEya0M46aUqj4RtjkbyIz/DLy3m1Fjy52?=
 =?us-ascii?Q?2uXYAYfCm06NoHFFb1hLNYnk6xmFGXMXwpDrwFKe5lASqlKCL9xuVCULMkyJ?=
 =?us-ascii?Q?r+9pw+20ldNzW9FQcRrP98Lb6Zp4Bd83O22HuQtp3WM5EpakC7YGjdA4oOpJ?=
 =?us-ascii?Q?K3N5L9PeGT6ScMFLJHnPbwcqcoMq7q04qawDvC1ZmWaCxpo9ppmAS1/t5nzH?=
 =?us-ascii?Q?quMFLOJ+R8aS6Z1qQnwJqD6Iwu7CBPx/1vD1Ggtta4NirGIoTGTtjkmcEGym?=
 =?us-ascii?Q?8tC5IBMpnmXD82ui15uqIgNq35r2d2XRwb5oRalTDTe9zAEadXlyqeHqcXXi?=
 =?us-ascii?Q?M20jQYfrXm8db8HiGjAbOfzev/Rj0LxEDR27iD8To2iz9suRVsGAVaJkllni?=
 =?us-ascii?Q?Nut6Z5dOH3TecpO8K5WjMejyPHvtQVhjIjuo5xNp?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b984600d-a97b-4ade-d28b-08dcac88dbea
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 09:04:58.7351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bEChkICMWEjsBEIK+lgQiBexk+U4Ymd4At5XJzpQXd3SXud2xnfwNKY84bSXCR+sMKRbQdkg+eFfQfzk3bBZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5762
X-Proofpoint-ORIG-GUID: zXSJV-3YqRfLhPF3phQ358u7Spx7xqGP
X-Proofpoint-GUID: zXSJV-3YqRfLhPF3phQ358u7Spx7xqGP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_09,2024-07-25_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2407110000 definitions=main-2407250059
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 09:05:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/475

The pam_lastlog module is deprecated and disabled by default in
linux-pam since 1.5.3[1]. Comment out this line to avoid loading
pam_lastlog module by default. Users can use lastlog2 provided by
util-linux as an alternative[2].

[1] https://github.com/linux-pam/linux-pam/commit/357a4ddbe9b4b10ebd805d2af3e32f3ead5b8816
[2] https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?id=c2e299d0acb2fa4ad1691452fa0eae76520bbdb0

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-extended/shadow/files/pam.d/login | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/recipes-extended/shadow/files/pam.d/login b/recipes-extended/shadow/files/pam.d/login
index ec5bba9..e0ca0e7 100644
--- a/recipes-extended/shadow/files/pam.d/login
+++ b/recipes-extended/shadow/files/pam.d/login
@@ -66,7 +66,10 @@ session    required   pam_limits.so
 
 # Prints the last login info upon succesful login
 # (Replaces the `LASTLOG_ENAB' option from login.defs)
-session    optional   pam_lastlog.so
+# Use pam_lastlog2 provided by util-linux instead of
+# pam_lastlog, as the latter has been deprecated and
+# disabled by default since linux-pam 1.5.3.
+#session    optional   pam_lastlog2.so
 
 # Prints the motd upon succesful login
 # (Replaces the `MOTD_FILE' option in login.defs)
-- 
2.25.1



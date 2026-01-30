Return-Path: <wei.deng@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A2DD73EBF
	for <webhook@archiver.kernel.org>; Fri, 30 Jan 2026 05:38:57 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4711.1769751534447150156
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 29 Jan 2026 21:38:54 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@qualcomm.com header.s=qcppdkim1 header.b=gtOu8jxM;
 dkim=fail reason="dkim: body hash did not verify" header.i=@oss.qualcomm.com header.s=google header.b=hzXUwMvf;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: wei.deng@oss.qualcomm.com)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60U3VSTP485884
	for <yocto-patches@lists.yoctoproject.org>; Fri, 30 Jan 2026 05:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hx5JMgWhFR+tc2tzcPNqlm2yEX68HySDRRxIPlWqs6Y=; b=gtOu8jxME92EzmTj
	JXbQ98Xyw/1V1viBspupdo7BA0Kmki3GdN3vOMqvjptTHa75fukQEhZqD8lo9KV1
	NSCyexrHkoemdyM35A50zsxmPkw5Cvsoye/alTZfCf2aLBtnWCMX4gQJXVVUzLc6
	Dy1sY+4QQSJn2sDwbTA9u9RoLTVikdhj7dftWCU1DOrCd/gdfL9pnTw4TojieTi/
	1AVBiXsT5BJJbpQBB2QLp7CSeeDjyCxnZjkKGln8/hUm0n7HckHIYVgugeRUX4gX
	zexAsyM2RqITNs7mdvDifftwAWru3z2i/oXxILOmJgs0O/tyfE3S0yRaY4O6mw06
	BMQh5g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0gtngwft-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 30 Jan 2026 05:38:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c6a182d4e1so33773585a.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 29 Jan 2026 21:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769751532; x=1770356332; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hx5JMgWhFR+tc2tzcPNqlm2yEX68HySDRRxIPlWqs6Y=;
        b=hzXUwMvfdY6QX++/P1aK06DyrMnJJw18407eOerPcbBaOnudJ4x/I+mGmsDHkeSDDq
         QLhk2/FW/HMpXir+mlNfwwifejDxs+3ZNN7YdeQuZLfbKaZVN+pantBpR4yxqZNPvhTf
         XTwv9YTFznqU7vmBP7foSPE84dX8IvPNwzEMkpBfrZLXDxcH2mSQMykbTljNBsabvo+y
         udFDCXvGlc6tfbKZMkTARdu8No5xXIQBb93O5MX8sFnGdpdgP9QLaznQsPn0zJhIcVOD
         7e6U1pgRyjpBUwVkdOd6XWdYDMzE6Ltklau3iDq2zdsw7ioN+vag8zRZnbYvDyO5Rpc3
         QBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769751532; x=1770356332;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hx5JMgWhFR+tc2tzcPNqlm2yEX68HySDRRxIPlWqs6Y=;
        b=Nerex5wbx7AS1pTdx4dEmu/XfyveZHdMtmmt8SC5vWU25X9nC1XnCq6pTswK4Ut12p
         wpQCmvxuZB/m4a1XAz3XYYJFTX0kYoT2U6Xl2Nk4InEjL6JEYPVEVz5LJBdCCxsuu1PF
         GW0L38fULUqcNfP7vk/daJkybbRoR/FrLJlVna+ZkukZqjkBYHK4vJmD9BSFfs6BDGZ6
         1wXf/vX3ijA+tSaAmLCreS3Q/oYa9tFlSH+IQt/rZz8dgdI8kdbwCZNG+Il522ktz25O
         wK5KfN1ctUKJSD6E/PAOJNV0EN2TzTtGK/3nQPS3vo+z0pn1u2OodpuHPVHeE6Deqewp
         fjFQ==
X-Gm-Message-State: AOJu0YxbWYhTdWLgkcU34ktPQ1HQr81Pk7Cdn1uFw6xgQ0EDg2ixlBjS
	Yn9jyzF9KK3agePtwXGUBFmvY0ag1y6HhnKi73myK8fLqQ7W1Or5LnrKEgCNWqdDErdvtSgqgP0
	blZqWKX7CkdVSnrPT2WCv3s492PQONyHs3sBdh7dqz0Wg9eyVa1kcucAv9G5Vx5nKbUXYkmxjMZ
	IWwMt0d6K6Uflc
X-Gm-Gg: AZuq6aIgynvjSS2kLCFdCugBoFH3x9XAvRpxkRRcvX2fs9DN3kc1Y5DICHUCSqlGh4G
	NnhO/3+E9ER5ratUnzxm5T3dn+uVxjb/v9Q5qBl3mRmwvfp5REEyCRyRfkIio8VB+iM3OeVF3dZ
	rv3nkeNEe8O/wa+xS3S1OZEVpG20Ph2I6zBkSqsogIOtucKmmxqOxXeTSKySV2U6HB/pKU5bYY0
	H09ZHX68MQtzbNuyuohNNAsjQyLvnToCGXZIGcSbrhJ1J8H4HjWvWWA/oiPVxQmymp0iUmYXurh
	IBKm4euKgyIcvKOlGVp5qf0XtN8a5qDfbO+nDzOoVcAR2k/L9UoHNVyeNthMjuoBoHkuIFjhkS5
	Zr8vpytIDru+0k4saiA0osd4r78XQ9oUJN5Rgcmhn4eWq7GT1bFiQzgPxlkOjZWqrQOea
X-Received: by 2002:a05:620a:a91:b0:8c9:ec71:b224 with SMTP id af79cd13be357-8c9ec71b47emr108212785a.0.1769751532210;
        Thu, 29 Jan 2026 21:38:52 -0800 (PST)
X-Received: by 2002:a05:620a:a91:b0:8c9:ec71:b224 with SMTP id af79cd13be357-8c9ec71b47emr108211685a.0.1769751531742;
        Thu, 29 Jan 2026 21:38:51 -0800 (PST)
Received: from [10.38.244.118] (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b7c7besm557250585a.2.2026.01.29.21.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 21:38:51 -0800 (PST)
Message-ID: <50724a7f-6cc7-41c6-9406-017777b7801f@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 13:38:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH] [meta-selinux][master][PATCH] refpolicy:
 brctl - add changes to access devpts
To: yocto-patches@lists.yoctoproject.org, yi.zhao@windriver.com
Cc: cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        quic_mohamull@quicinc.com
References: <20260128150814.2273926-1-wei.deng@oss.qualcomm.com>
 <aae1b4af-225b-4c7b-a573-ccb3f8a04c1e@windriver.com>
Content-Language: en-US
From: Wei Deng <wei.deng@oss.qualcomm.com>
In-Reply-To: <aae1b4af-225b-4c7b-a573-ccb3f8a04c1e@windriver.com>
Content-Type: text/plain; charset=UTF-8
X-Proofpoint-GUID: Dmby_cnVbWQlj7RpGeD88K67tRuF99W1
X-Authority-Analysis: v=2.4 cv=FPcWBuos c=1 sm=1 tr=0 ts=697c43ed cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=iGHA9ds3AAAA:8 a=EUspDBNiAAAA:8
 a=zGLdpGTcPXso3dszK0AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-ORIG-GUID: Dmby_cnVbWQlj7RpGeD88K67tRuF99W1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDA0MSBTYWx0ZWRfX/s3GbEMqgyJm
 41yT/kxF2Es1z/Ou6IsoKSi0tyM4OnZCOpeh0y1CyEuCWAGjOZNBhpHvmwwJt8MftVDJf8/Ltdk
 UD920DlEEYXeQOspoyNPFVKZr4YNRiHF6OjPPn09ZYvMw8NqWM3rUCbGgPAgplN9tNe//vG72Q0
 BXEqWd58iI9nYY6DW2rxYi0M+SqfpDXKGOcn2hk1/2koZA9kG7s/wIOyAriqzOZ2+MxPpu2SooJ
 uXwpOBcnNmKN9XQNYo2pORx3P1Z9uFhToQI2+y43lZ37l4p+DNuQpSAwOEr9Ycs8aM2chP1v+p2
 Ejg8m/7+yrxVSm5ScpebML4BDSStiQQT0KpFodUi14Vuz229YHnEbxpbyaueeZrsRKXYM/NG4vk
 Db4DUeIWQbpfptuXuim2MLGQVV/oPkKHsgNPOhVO1lF+3Yeh4nhp7iGOCc4VlptGH5PLR/EpIlY
 krsVJLVYA67Hnna94bg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300041
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0031df01.pphosted.com id 60U3VSTP485884
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 30 Jan 2026 05:38:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3149

Hi Yi,
Thanks for your reply.

On 1/30/2026 11:22 AM, Yi Zhao via lists.yoctoproject.org wrote:
> Thanks for your patch. I won't merge it at this time because I am curre=
ntly working on updating refpolicy, and this backport patch will be inclu=
ded in the updated version.
>=20

We have another patch need backport as below, hope it alse be included in=
 the updated version. Thanks.
https://github.com/SELinuxProject/refpolicy/commit/1783c0c4eb9aaff6b7b1b1=
8fbd86f933e398ce5b

>=20
> //Yi
>=20
> On 1/28/26 23:08, Wei Deng wrote:
>> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
>> ---
>> =C2=A0 ...cy-modules-admin-brctl-access-devpts.patch | 39 ++++++++++++=
+++++++
>> =C2=A0 .../refpolicy/refpolicy_common.inc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0 2 files changed, 40 insertions(+)
>> =C2=A0 create mode 100644 recipes-security/refpolicy/refpolicy/0057-po=
licy-modules-admin-brctl-access-devpts.patch
>>
>> diff --git a/recipes-security/refpolicy/refpolicy/0057-policy-modules-=
admin-brctl-access-devpts.patch b/recipes-security/refpolicy/refpolicy/00=
57-policy-modules-admin-brctl-access-devpts.patch
>> new file mode 100644
>> index 0000000..cc6abd1
>> --- /dev/null
>> +++ b/recipes-security/refpolicy/refpolicy/0057-policy-modules-admin-b=
rctl-access-devpts.patch
>> @@ -0,0 +1,39 @@
>> +From 43ef3db9bc4247222d773bb24da71352bf84f4e5 Mon Sep 17 00:00:00 200=
1
>> +From: Wei Deng <wei.deng@oss.qualcomm.com>
>> +Date: Tue, 20 Jan 2026 08:28:45 +0530
>> +Subject: [PATCH] Sepolicy changes for brctl to access devpts
>> +
>> +Resolve selinux permission for brctl tool failed to launch in adb mod=
e
>> +with enforcing mode enabled.
>> +
>> +Below avc denials that are fixed with this patch -
>> +
>> +avc:=C2=A0 denied=C2=A0 { read write } for=C2=A0 pid=3D1407 comm=3D"b=
rctl"
>> +path=3D"/dev/pts/0" dev=3D"devpts" ino=3D3
>> +scontext=3Dsystem_u:system_r:brctl_t:s0
>> +tcontext=3Dsystem_u:object_r:initrc_devpts_t:s0 tclass=3Dchr_file
>> +permissive=3D0
>> +
>> +Upstream-Status: Backport [https://github.com/SELinuxProject/refpolic=
y/commit/43ef3db9bc4247222d773bb24da71352bf84f4e5]
>> +
>> +Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
>> +---
>> + policy/modules/admin/brctl.te | 2 ++
>> + 1 file changed, 2 insertions(+)
>> +
>> +diff --git a/policy/modules/admin/brctl.te b/policy/modules/admin/brc=
tl.te
>> +index 026b0002d..45ca94c60 100644
>> +--- a/policy/modules/admin/brctl.te
>> ++++ b/policy/modules/admin/brctl.te
>> +@@ -23,6 +23,8 @@ allow brctl_t self:unix_stream_socket create_stream=
_socket_perms;
>> + allow brctl_t self:unix_dgram_socket create_socket_perms;
>> + allow brctl_t self:tcp_socket create_socket_perms;
>> +
>> ++init_use_script_ptys(brctl_t)
>> ++
>> + kernel_request_load_module(brctl_t)
>> + kernel_read_network_state(brctl_t)
>> + kernel_read_sysctl(brctl_t)
>> +--
>> +2.25.1
>> +
>> diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes=
-security/refpolicy/refpolicy_common.inc
>> index 59dfecd..4af7f43 100644
>> --- a/recipes-security/refpolicy/refpolicy_common.inc
>> +++ b/recipes-security/refpolicy/refpolicy_common.inc
>> @@ -72,6 +72,7 @@ SRC_URI +=3D " \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://0054-pol=
icy-modules-system-setrans-allow-setrans_t-use-fd.patch \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://0055-pol=
icy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://0056-pol=
icy-modules-system-logging-make-syslogd_runtime_t.patch \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://0057-policy-modules=
-admin-brctl-access-devpts.patch \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "
>> =C2=A0 =C2=A0 S =3D "${UNPACKDIR}/refpolicy"
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3147): https://lists.yoctoproject.org/g/yocto-patch=
es/message/3147
> Mute This Topic: https://lists.yoctoproject.org/mt/117539373/10240238
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/14866=
895/10240238/1555622025/xyzzy [wei.deng@oss.qualcomm.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20
>=20

--=20
Best Regards,
Wei Deng



Return-Path: <wei.deng@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5253EA7954
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 01:56:06 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11657.1770256564015905527
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Feb 2026 17:56:04 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@qualcomm.com header.s=qcppdkim1 header.b=pyz+G8fV;
 dkim=fail reason="dkim: body hash did not verify" header.i=@oss.qualcomm.com header.s=google header.b=PtPt4vix;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: wei.deng@oss.qualcomm.com)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6150YcsA3001232
	for <yocto-patches@lists.yoctoproject.org>; Thu, 5 Feb 2026 01:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zuOSdSJPH4/KS2qQN8wEhON06EpNnBjP8cLyP4LUHo8=; b=pyz+G8fVQIzve7Xa
	gm46EMy/BUyeZVtyo2lltwK04gVjKyDyXMO9+H2c0LJ/LkitsujQKPVbzqvkhsO8
	sFUj0AZEQZA9lHh9sKPLiVOfVBIYAmPOV6mafPeyph9b0d2lDV7Q5bPwSkOZBjoN
	tbWHJjXHOH335j0J6JEWbo4hQqs3KT0A35/FvdnlPzW+oMDYaZnlmJTPspbXAbaI
	r6/nNY6UrdjuKMu2BTKnuQi0ycVlNtorbGz2S5M91CoX1yNc2T4BPIIMps9r9RHo
	y/JZSw0MNpMgyAhTgxbeaG+AiYRpV6coDhCXuQxvpfXTROWhCg9phgHqNHfqOnvB
	iag2vg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c43dh2s4p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 05 Feb 2026 01:56:02 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c53892a195so8538385a.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Feb 2026 17:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770256562; x=1770861362; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zuOSdSJPH4/KS2qQN8wEhON06EpNnBjP8cLyP4LUHo8=;
        b=PtPt4vixwk7USRzFzHjbOfNcZy/r1nN5zjBje5PN0KN1NtS8UrB8FxhWkH3ycfyoOF
         JMaz8dMUh66X1tZPPq/hwYTUjQCFT6jT+DX5iB33lfj0rBEnCgadWncqEMgLS4nu2/nL
         Ks86M6E3VncLJR53nrRv2E+kDJA0YCI/tMPynNKND8C8esDe1hBV0ccDqpkDLxY9Hizu
         TUMOw1+C4UypOPJoCdT1VI5qcHMuZ1uc+FEec1tSCh10DxYtYuouI72MASkyXj2Hnyqq
         HldKHgcT1z0B1qdoR1vKR+Kzi0xe7JAyZ14kwuji9Cph036mI1XmYrOzZdvvrTdUezkl
         Wjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770256562; x=1770861362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zuOSdSJPH4/KS2qQN8wEhON06EpNnBjP8cLyP4LUHo8=;
        b=XNgpuuCU+4TwgWqTn04AHsu64I473sTi+m1lXjLpFBKG0FXGjvgrB1kY42fimkIKB4
         Z295ClWexk/hbeAJeklKFHAl/5T7Rlba+OFjCstsHZVt28hmDHzlo35klCshOa7Oe/Fi
         YvjVIiyn5Ti3kNL/NL3/AAx+HqKZLuwGicR8DM6bYOueEfjcnv/RGMOaRdE93pSg50W0
         CQk+IEoxjRGqEwx2P9MSWxrBbn8RsfDe80/GBiDSzT66im05uQsUc+RTP78ajd6oi5pv
         dVmghqMOAYoADc3we+5E31jOWiba/f3iODMYUNEtJGYymLNC/UUBqM33n7Tx7vo7vGSP
         mPRg==
X-Forwarded-Encrypted: i=1; AJvYcCVHMAK0uXEKMhzVveLp1QtG3bJsVxXXgCoLUfYLi9uCw/oDhPwj6+L7FIWCFyRZiFgR6UP3SKZq4kkdoEza@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yw+BMJJXJ7oYw13/7koNGGLHjS7VkjsfTUkaX0QXFGAh5rxQBwA
	jR7sApTjS1E3VXK2fS0nE1GSdbS04fPPOtG+6Bsc3AWGjGiQaEKKi7RFLUP03v/gtjVV+EmsxrK
	lla+qUVFhqtWLNo4CXjOtupyxu3Qma7gjRQ5bBuB7//m2vCSf11i/1OC/ND/vKpNhFBUs0oHoU7
	jRpQ==
X-Gm-Gg: AZuq6aIcdtN+D7YbmacxaP0Qu9OVDZGROxqgwiOLngWMyCX+kN8W5WmczUjjhXjseRM
	koDVYA7wsLpSM/rPccEcRVtmuRqe7vLOJbjJvLLaAQkS6TOWxk1465DL1gOWqC/zCr21OiGPcHW
	/ymaJfpWiKE8Zri+WSs0dhNtPkLYVNvInlhFO8UrdpqGMgogEk63xhp2R/YSAegIbxr8dK4wVOJ
	daQo3HGMo5Vtlcr4yKqCjAQVclrg6SbvNLfPuzot5vNEVCwv0GA6Qxld5yFUVhx2aGxfDObiMUi
	fDXzdtJQCoYu7iNcyIztKfDj43W/fz7bFFTP9y4WhtxG7M7mWc4G0llqD0q65HQu1PikNvaDnBD
	4ON/gZ2XR/FOtruRAlyfkuS/gaZhNUf+dImtqWZOa6IXJeAqMNH04QWOeRO+2JTc+Lnthfg==
X-Received: by 2002:a05:620a:444a:b0:8c6:f7ad:49b with SMTP id af79cd13be357-8ca330a79camr414939085a.5.1770256562115;
        Wed, 04 Feb 2026 17:56:02 -0800 (PST)
X-Received: by 2002:a05:620a:444a:b0:8c6:f7ad:49b with SMTP id af79cd13be357-8ca330a79camr414937385a.5.1770256561609;
        Wed, 04 Feb 2026 17:56:01 -0800 (PST)
Received: from [10.111.175.210] (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fa821b7sm333375485a.20.2026.02.04.17.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 17:56:01 -0800 (PST)
Message-ID: <a99ab9c9-a364-43c9-b59d-afa16663c308@oss.qualcomm.com>
Date: Thu, 5 Feb 2026 09:55:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH] [meta-selinux][master][PATCH] refpolicy:
 brctl - add changes to access devpts
To: Yi Zhao <yi.zhao@windriver.com>, yocto-patches@lists.yoctoproject.org
Cc: cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        quic_mohamull@quicinc.com
References: <20260128150814.2273926-1-wei.deng@oss.qualcomm.com>
 <aae1b4af-225b-4c7b-a573-ccb3f8a04c1e@windriver.com>
 <50724a7f-6cc7-41c6-9406-017777b7801f@oss.qualcomm.com>
 <8bc62b8a-ace4-4f1e-af85-ef0e2d920061@windriver.com>
Content-Language: en-US
From: Wei Deng <wei.deng@oss.qualcomm.com>
In-Reply-To: <8bc62b8a-ace4-4f1e-af85-ef0e2d920061@windriver.com>
Content-Type: text/plain; charset=UTF-8
X-Authority-Analysis: v=2.4 cv=bMgb4f+Z c=1 sm=1 tr=0 ts=6983f8b2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=iGHA9ds3AAAA:8 a=EUspDBNiAAAA:8
 a=NM9XRvL1BakDqXr1vmgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-ORIG-GUID: qdtN0lpQuo2hG11jex-PBMLDWGC86-O2
X-Proofpoint-GUID: qdtN0lpQuo2hG11jex-PBMLDWGC86-O2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDAxMiBTYWx0ZWRfX+ybYWEnG8Wgd
 zdUxA6XSv5Eehu/rlyUlIkvJAj73AVr/osbL8iuD/VJjNknEnC7M3XPiP9Duvh7+JbxOXXQqljJ
 OV1pUfuvSGISyOq1TVgXnBWUpTNHKxM2c6wN6cCfnuj3J6CqKmQLTXz6fcSHEY6uVFdGpSse7rA
 BenxlIBJFfp5AB6hwRgSwQr1N+4Jz9tC7XSU97YeVV+UghwS1NxUX/LDgrdjy7ob+O4nmjQ1KEO
 /jqnVkbvm4Y+0VklS8I/mOQrC5CelKKuxTEorUIcN6jleq/BERvGgALRYw0UCVngQO7kKEVAA/A
 B9Ena7qmUGKRSlS0aBhMzlKu/11aQSF94EWWJQRJisSXN+sOZ+AagJZ59gx5pi0Bota/8rJeWAD
 itBAD+m7d2afI7+FKbxRUO0/18s1ISG7sCZL1MfibrkRz3CfVKwvrSIpfoT2XE2U7AnwU299ugv
 XmnN7Rgzu+Q/Na8d4kQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_08,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050012
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0031df01.pphosted.com id 6150YcsA3001232
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 05 Feb 2026 01:56:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3191

Hi Yi,

On 1/30/2026 2:47 PM, Yi Zhao wrote:
>=20
> On 1/30/26 13:38, Wei Deng wrote:
>> Hi Yi,
>> Thanks for your reply.
>>
>> On 1/30/2026 11:22 AM, Yi Zhao via lists.yoctoproject.org wrote:
>>> Thanks for your patch. I won't merge it at this time because I am cur=
rently working on updating refpolicy, and this backport patch will be inc=
luded in the updated version.
>>>
>> We have another patch need backport as below, hope it alse be included=
 in the updated version. Thanks.
>> https://github.com/SELinuxProject/refpolicy/commit/1783c0c4eb9aaff6b7b=
1b18fbd86f933e398ce5b
> Yes. This will also be included in the upcoming update.
>=20
> //Yi

Thanks for your confirmation. When you have a moment, could you please sh=
are if there=E2=80=99s a tentative timeline for the version update?

>=20
>=20
>>
>>> //Yi
>>>
>>> On 1/28/26 23:08, Wei Deng wrote:
>>>> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
>>>> ---
>>>> =C2=A0=C2=A0 ...cy-modules-admin-brctl-access-devpts.patch | 39 ++++=
+++++++++++++++
>>>> =C2=A0=C2=A0 .../refpolicy/refpolicy_common.inc=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>>> =C2=A0=C2=A0 2 files changed, 40 insertions(+)
>>>> =C2=A0=C2=A0 create mode 100644 recipes-security/refpolicy/refpolicy=
/0057-policy-modules-admin-brctl-access-devpts.patch
>>>>
>>>> diff --git a/recipes-security/refpolicy/refpolicy/0057-policy-module=
s-admin-brctl-access-devpts.patch b/recipes-security/refpolicy/refpolicy/=
0057-policy-modules-admin-brctl-access-devpts.patch
>>>> new file mode 100644
>>>> index 0000000..cc6abd1
>>>> --- /dev/null
>>>> +++ b/recipes-security/refpolicy/refpolicy/0057-policy-modules-admin=
-brctl-access-devpts.patch
>>>> @@ -0,0 +1,39 @@
>>>> +From 43ef3db9bc4247222d773bb24da71352bf84f4e5 Mon Sep 17 00:00:00 2=
001
>>>> +From: Wei Deng <wei.deng@oss.qualcomm.com>
>>>> +Date: Tue, 20 Jan 2026 08:28:45 +0530
>>>> +Subject: [PATCH] Sepolicy changes for brctl to access devpts
>>>> +
>>>> +Resolve selinux permission for brctl tool failed to launch in adb m=
ode
>>>> +with enforcing mode enabled.
>>>> +
>>>> +Below avc denials that are fixed with this patch -
>>>> +
>>>> +avc:=C2=A0 denied=C2=A0 { read write } for=C2=A0 pid=3D1407 comm=3D=
"brctl"
>>>> +path=3D"/dev/pts/0" dev=3D"devpts" ino=3D3
>>>> +scontext=3Dsystem_u:system_r:brctl_t:s0
>>>> +tcontext=3Dsystem_u:object_r:initrc_devpts_t:s0 tclass=3Dchr_file
>>>> +permissive=3D0
>>>> +
>>>> +Upstream-Status: Backport [https://github.com/SELinuxProject/refpol=
icy/commit/43ef3db9bc4247222d773bb24da71352bf84f4e5]
>>>> +
>>>> +Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
>>>> +---
>>>> + policy/modules/admin/brctl.te | 2 ++
>>>> + 1 file changed, 2 insertions(+)
>>>> +
>>>> +diff --git a/policy/modules/admin/brctl.te b/policy/modules/admin/b=
rctl.te
>>>> +index 026b0002d..45ca94c60 100644
>>>> +--- a/policy/modules/admin/brctl.te
>>>> ++++ b/policy/modules/admin/brctl.te
>>>> +@@ -23,6 +23,8 @@ allow brctl_t self:unix_stream_socket create_stre=
am_socket_perms;
>>>> + allow brctl_t self:unix_dgram_socket create_socket_perms;
>>>> + allow brctl_t self:tcp_socket create_socket_perms;
>>>> +
>>>> ++init_use_script_ptys(brctl_t)
>>>> ++
>>>> + kernel_request_load_module(brctl_t)
>>>> + kernel_read_network_state(brctl_t)
>>>> + kernel_read_sysctl(brctl_t)
>>>> +--
>>>> +2.25.1
>>>> +
>>>> diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recip=
es-security/refpolicy/refpolicy_common.inc
>>>> index 59dfecd..4af7f43 100644
>>>> --- a/recipes-security/refpolicy/refpolicy_common.inc
>>>> +++ b/recipes-security/refpolicy/refpolicy_common.inc
>>>> @@ -72,6 +72,7 @@ SRC_URI +=3D " \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://=
0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://=
0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://=
0056-policy-modules-system-logging-make-syslogd_runtime_t.patch \
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://0057-policy-modul=
es-admin-brctl-access-devpts.patch \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "
>>>> =C2=A0=C2=A0 =C2=A0 S =3D "${UNPACKDIR}/refpolicy"
>>>
>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>> Links: You receive all messages sent to this group.
>>> View/Reply Online (#3147): https://lists.yoctoproject.org/g/yocto-pat=
ches/message/3147
>>> Mute This Topic: https://lists.yoctoproject.org/mt/117539373/10240238
>>> Group Owner: yocto-patches+owner@lists.yoctoproject.org
>>> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/148=
66895/10240238/1555622025/xyzzy [wei.deng@oss.qualcomm.com]
>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>>
>>>

--=20
Best Regards,
Wei Deng



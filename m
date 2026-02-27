Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4AAFD5319
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 09:12:49 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.91229.1772181857014781170
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Feb 2026 00:44:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=Fy0I0R3g;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=Mf4qWRIh;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: koen.kooi@oss.qualcomm.com)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R2JwsZ2403004
	for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Feb 2026 08:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vuMtBs0e0NjFspoL16WzUAV6YzGtm2fwJxnayXM9IBE=; b=Fy0I0R3gN6kJWmex
	HW5xkXLVZY06L9r97j9iqxNM60ywAu/cJOio3elnt0jVIpN7hLkSrtOhDEzM/jUd
	QusmV26K5mme0MHrcRMjm+CJdWhD9AlZrr0Zk8M/IzwvoCALqi9Qpj6eUS/baIQn
	fc8pY1MH48Y1anXlNA2AbgkvABvWPa+Ego2Md3PJXkbHbtIf6KUN5b9znWBL1QGs
	dckT4ViK+Ml1fbdeHOP2HxTTGArMMhmkjFQowaPdZJ85g6X8yl6okMu8FMkNeoz5
	z7OhhKRKqtRcmxAq/M3GrS0tV5vLHNx79uUk41EghxDqutR73GbuH5UXpZDDmbjV
	4mBV6A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjw23a2eg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Feb 2026 08:44:15 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8ca3ef536ddso1647801485a.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Feb 2026 00:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772181855; x=1772786655; darn=lists.yoctoproject.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuMtBs0e0NjFspoL16WzUAV6YzGtm2fwJxnayXM9IBE=;
        b=Mf4qWRIh/KBPeE7kCPPAQ8F6pjYlOXcDUJ756XOpWH9JOF03oc70sk2RKleqXX6RvO
         W5jAjZ0uVdJJfOBrr1iCjEQYhZlsnrgvkMB1fVNgOKQcCKNfmjIws1kQg1Op+6L/r9ZO
         ZjwxLj180a4bpqY+gQoT7/rI5Pjbpx9L8Xy5pRnkVwFMNPaAiCJryd/g7hvFQUvh4OyZ
         z8d7ZRHQBRHDUTxs/Ex5i5GVOJDcAnuIR5zOnl94HqRNLiIg65bAWZqzKetC0yGgDaH9
         Q4D8pgyU/XTopN4u7g09j1uvdjqWG4ks1gn2iE/DIzIFNUwz+2e+TuXb0NH72N9OljiJ
         7Z0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772181855; x=1772786655;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vuMtBs0e0NjFspoL16WzUAV6YzGtm2fwJxnayXM9IBE=;
        b=DL+a1owJkrnLNKjZjsDy6g81k60rJP7u52L+9PHckG6zgbhWaBbNFVx0W7AEBrw0v1
         dEEtGHHIAjINR/B9DVCGfb6SidrK2rRFcfpcCNkkjs7FVZVhUVYycbA5jjNsxwfvWUHI
         IKz6yZeDZQm9A5nild6vbq3iApiimoTjaECQwoMs+m/BV/ykhi8kI9AmKNNP8/8CuOUG
         PqY3WH+CBp7mwyo0rbF13DsuFItQ0lfRdewqAr+6pxl1UsUTpsKBOBZC70w+YAbkwUqq
         YwEJYIGuXOokkh06N2zXrU1LMV7SE6Qos09mrS795tbBhMiMhX5eccaV1nhiZobEBRe0
         3E0w==
X-Forwarded-Encrypted: i=1; AJvYcCVUKKayqGjK08rOku2yf/RUQEziUYUWId6MAkj/mpyc/zky7T0LPhrdjUlEy6hWZspUwPPl8eJHw/XKWSG6@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YwrKR8QUD8MtI7GxTBnNg78vC1CTjzGkqSKB0yZkU7gocXwHumG
	0auq8qjP6YisVd+qj3cQ7+q4u5a9M6UKKBKSD5bdhI8hXoBevgWIcmbYHmAJ2KFBYed4lhYdFNL
	0l5MWJEFZRcVVwIpiQP89fIUKU3VkcO0y8UbRO7ojZWmIbu/+C+6OVolkWNOgkiTMgf7QfESquW
	dwJw==
X-Gm-Gg: ATEYQzw+vrxD3EEgyo8qBkf0J1Pp1LeRezfk5VjZ2pW+0t7UUcdbSAUzmP2jiLjVRcm
	joALzSYpyjJ+DIKml4o49ATLkxjz11q72V5MJLD9RMKUBLkrv6dI1F7Uj1DxMRStmyXp5AiEVxC
	9z5pXkrpb9WDtU2/UArl5dp2djK8ZIQMvkdXHWrx/shPouJKwYJMc+Z1j48ux0C2PcitVeD9tNW
	2zcGmXvQq4cqQI52Tadk66FrCirSa6siRUuS17sYlwgI0TCF3LfALcGXRMKOLjhnMyyg3HioQTq
	EOLbWEbckPk02Rpc1p6Z9TBEsqS4tQNdNTKFV4MkuEttTPKKQ/bQIeuvLf7pg8zGyY3IYuBJMnd
	DvQYUls/wl/MP6Qi/h4z+yG5p3T+lKgGb779/MuwSrgK/1jv2XHz+FGsayz876t9rrTWbTiP8Oy
	KMPA==
X-Received: by 2002:a05:620a:2956:b0:8c7:fdc:e872 with SMTP id af79cd13be357-8cbc8d9e73cmr235252685a.19.1772181855105;
        Fri, 27 Feb 2026 00:44:15 -0800 (PST)
X-Received: by 2002:a05:620a:2956:b0:8c7:fdc:e872 with SMTP id af79cd13be357-8cbc8d9e73cmr235250285a.19.1772181854511;
        Fri, 27 Feb 2026 00:44:14 -0800 (PST)
Received: from smtpclient.apple (185-047-135-246.jonaz.nl. [185.47.135.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935aeee867sm129667066b.66.2026.02.27.00.44.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Feb 2026 00:44:14 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [Openembedded-architecture] Running Large Language Models Locally -- Contribute meta-ollama to Yocto
From: "Koen Kooi" <koen.kooi@oss.qualcomm.com>
In-Reply-To: <a9595b8e-813a-4dd0-ba7c-ae0138cff01f@windriver.com>
Date: Fri, 27 Feb 2026 09:44:03 +0100
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
        Michael Halstead <mhalstead@linuxfoundation.org>,
        yocto-patches@lists.yoctoproject.org, Khem Raj <raj.khem@gmail.com>,
        Alexander Kanavin <alex.kanavin@gmail.com>,
        openembedded-architecture <openembedded-architecture@lists.openembedded.org>,
        "Yang, Zhangle (Eric)" <Zhangle.Yang@windriver.com>,
        Robert Yang <liezhi.yang@windriver.com>,
        Randy MacLeod <Randy.MacLeod@windriver.com>,
        Mark Asselstine <mark.asselstine@windriver.com>,
        "Holmberg, Tomas" <Tomas.Holmberg@windriver.com>,
        "Chen, Qi" <Qi.Chen@windriver.com>, Ross Burton <ross.burton@arm.com>
Message-Id: <FFF9C420-70C6-41C8-AD1C-7C815557CFF7@oss.qualcomm.com>
References: <34111501-e543-417a-b933-e3830a3cdf64@windriver.com>
 <8d6d05baeee00bfe96dfa816be9affe2ff0e421f.camel@linuxfoundation.org>
 <a9595b8e-813a-4dd0-ba7c-ae0138cff01f@windriver.com>
To: Hongxu Jia <hongxu.jia@windriver.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-GUID: 3CiW6ooLQPj3O2_EQkpLyqoAM-h8VDCi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA3MyBTYWx0ZWRfX08r8mnqI6cOf
 38IEwd/Y+4BLlDHTmSdsw2mwo8yDRvsr6z5ApoMgWJl5UwgBvqnWw7SDgcyCYnlzql9tV6upMCQ
 2NB1IL51SU0U4PYuMUvWgjtYTYUAJ6ujCKDPl7/ufTWGMKuEtqEatsyCi9K4iqVPOYcHyaan8cD
 BPLR+1w0/XyoZg0tBFcNAS4qw15QYDxDYcbcuxfwF8LUz2KFpmaKg9pDNmGAnNbSO/hxpT12Uh5
 Qe2CSBPah1sPc1drILbJVzNwr9XU0sZ7uzGzxxuPodllAKq84erMiowUqL2UXvZGYHlYPvwF4sE
 v0vgBemZSlbW3g1BpWXSIetfznbG7DnVY3nkwuV1ORkL0SH2+OIWTXnK0c2/PoZRKznDWxDsAku
 nQbZlen2feOrnAVVvsZS/6FtAuBEGbjaYAnarKV7arN0Q91HDQvMTTD853JMnwgw6myMIAHpbrD
 lC1GYW1zGAr08NwIpeA==
X-Authority-Analysis: v=2.4 cv=cJHtc1eN c=1 sm=1 tr=0 ts=69a1595f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=/kpjpRmFdjEkggKB3J9tkg==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=Q4-j1AaZAAAA:8 a=IvQJNAUUq8ru2VKf7xoA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=nM-MV4yxpKKO9kiQg6Ot:22
 a=FdTzh2GWekK77mhwV6Dw:22 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-ORIG-GUID: 3CiW6ooLQPj3O2_EQkpLyqoAM-h8VDCi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270073
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Feb 2026 09:12:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3297



> Op 25 feb 2026, om 06:22 heeft Hongxu Jia <hongxu.jia@windriver.com> =
het volgende geschreven:
>=20
> On 1/31/26 00:56, Richard Purdie wrote:
>> CAUTION: This email comes from a non Wind River email account!
>> Do not click links or open attachments unless you recognize the =
sender and know the content is safe.
>>=20
>> Hi Hongxu,
>>=20
>> On Fri, 2026-01-30 at 13:20 +0800, hongxu via lists.openembedded.org =
wrote:
>>=20
>>> Would you please approve to add this layer to
>>> https://git.yoctoproject.org/, I will maintain
>>> meta-ollama for recipe uprev and bug fix
>>>=20
>> Thanks for sharing this, it looks really interesting and I like the
>> idea of it a lot.
>>=20
>> Also, thanks for volunteering to maintain it, that does help =
alleviate
>> various concerns.
>>=20
>> Approval for this rests with the Yocto Project TSC so I have asked =
them
>> about it. We should have a decision after our next meeting.
>>=20
> Hi Richard,
> Ping, what is the status of the approval from Yocto Project TSC?
> About the suggestion to rename the layer to meta-ai or meta-llm and =
collect other LLM applications, such as llama.cpp.
> I am open to it, but I strongly insist to maintain meta-ollama as a =
standalone layer, further more, if we support llama.cpp later, we should =
add it as meta-llama-cpp
> Then we could customize and isolate each LLM application in a layer, =
including:
> - Add model recipe for LLM application, the format of LLM differs for =
each application (ollama vs llama.cpp)
> - Boot up LLM application for Yocto image, add systemd service file
>=20
> - Customize GPU support (CUDA) for LLM application
>=20
> If Yocto decides to use meta-ai or meta-llm, I suggest to add =
meta-ollama and meta-llama-cpp as the subset of it, such as meta-xx in =
meta-openembedded

What are the technical arguments for needing to put those into their own =
layers? As I've stated before, I'd like to have a single layer that has =
the most used AI/ML things and I can help maintaining that on company =
time. Splitting that into multiple layers would increase the friction =
for both consumers and developers of those layers.

regards,

Koen=


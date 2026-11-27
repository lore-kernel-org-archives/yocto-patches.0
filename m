Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.508.1795798482940876943
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Nov 2026 08:54:43 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@qualcomm.com header.s=qcppdkim1 header.b=SA4z4Faa;
 dkim=fail reason="dkim: body hash did not verify" header.i=@oss.qualcomm.com header.s=google header.b=E+Khb/DN;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARFp9JV2617606
	for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Nov 2026 16:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=o1qZppbUyNyInkK6fXEJxa
	TQ63K9AlS2stPBp83zvtA=; b=SA4z4FaaSCFyOOCjgf0aTzGaTIVrndcAy45ZJw
	hXYxD5LRHUeToSNQeiFpD/hw6dfPQFoBMwFn+jMxFSWhMdnxuMswctkLAOigbujr
	vjFAlmaXt/yGYZxx87Qqu9Xn09Dqm3QEKAdQueTMQt+VWshmR91+OYQQYqA4e+Sh
	vXn4bIeLuRt1KKPlw4bNlCVzCrX0oqAkXyJ/GMa8L/RUFd4icjwfcR4pSTpOrEtN
	xJXyDpkaCtZskroJK3EkfiaZBEapYi3rHpWNLoFTByK02QS8iWMYlr4K91y1WszE
	ZK6XVo9UOV0t65IT8gPIuS4ptLuV2YhxssnJmtUoo6Bit1Yw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u4huxhx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Nov 2026 16:54:41 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f37c94ceeso1454817185a.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Nov 2026 08:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795798480; x=1796403280; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o1qZppbUyNyInkK6fXEJxaTQ63K9AlS2stPBp83zvtA=;
        b=E+Khb/DNxkAI8W/hLlMmjUse/TaR0E8mXTVwr/ROAoy7vOPFT2OzChHkNUrDN6WK5U
         kvsPhTVL82WFr7LV6qNW5F2FIC3ai0mIxQ5pqSuCDoSY8AnZW+4fxcbCRIIqWiVexjp8
         1TGDzS8UNp6ZwA7hwnnauM4+geySkmQHtGXyBYFObTqhD7DYNXaLXbqYCz2SBr+HZG6/
         eNqgehAD5mPPTgBNdRvMrMQVoZ0SeExcoSQOjHWdy2RsTQDnfe1zuDFODc4fFspci+QK
         nREDOpqCxlCF3v9F79yfmqdPn2L5rjX7q+SBOxthNk/FLC3C6ruvA6K0+hHauyvx1rbX
         xftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795798480; x=1796403280;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o1qZppbUyNyInkK6fXEJxaTQ63K9AlS2stPBp83zvtA=;
        b=JslhEk3qcpRcNXPwlKyarPF2lAh7x2t4SyK/nFjJb/vlsfPtlydtYhUMHNwEwYJ9NA
         RoGt1IwpCv8dKwD60fetqT0vA8QdAzGP5TJHyeNzxjegHRpFhQ76m8oWLxX2FZNCnLY2
         sAOr/9XNYKSYh8FhsXXYhG0So/g4XtfX7mpJvITgYxnXJPRCpz4G7OXbvJK3oLUd287p
         MgNHZIjtxTn4zNHnfcnojdnjQu9g7emZuJDXdGAGTn+PWoecUZqU2smqUSjgIcKs37j0
         2balhhSzi4/aD2Unpslcr1qy2ad6MB1Eg20sfgluJtc7GZNx6c1fMxHu5sI08rFHv4vb
         BY6A==
X-Gm-Message-State: APuU4Z9GAqbjov1em7bDH9MlXtofyIAa1HrPHeOZ0dLxUD1HNQqs8MLs
	ut1qH1/LbEaqX5Th6sh94aFE7eXfb415P4Bg8zj7ysbSVcj5MmzEw0qkBjGQCrYOdhCaaOfPUTr
	rOckUgTJBlEXS0t7Tv01rG7hWZ66uqTxNwC/s2aT0nb3KyNDA4owhHldClBpuxEOt5fgMbvVu6T
	v0RIAsLCsdw4aE
X-Gm-Gg: AZFdTZfdGs+NTVJy5BfMlnvAupz7biVsyihmetYwfyhZ0/MFrRAxeLYz329dSIJEk6w
	rROq4EVx0Ao+HFdyVokAmyuq+NkrWdAZta9QAxGvjZAecaIm6Jjbxq3hm2xMPAiAQzPTzuAWmB4
	Ns2/xMgZtOiLoJIWTNLc/zOHhyeogrDoJG89fiDpVx1y2NtgVwaQKCYGsnXk4LdMwWogP6yfHla
	nw1knZ8bj6r8gXRaqamif/veH4LaZuJubGaugYO4ymdhLiH/XOgsnT9H6E+JpKOU7CO4Su2fG5v
	x6pqgb//H0itinbWzSwSAthOvM2VNi2QRbJxG11pBc8ksoAuhBiv6KTGwJ+E2hjmkUa0DMAfI8y
	4o99aE3peBcAEQpy2twa9cjsvMxZKrC8rI9PpzzcSneYy2JwvuYDf+WVtM3jRECY=
X-Received: by 2002:a05:620a:408b:b0:949:3cfa:8592 with SMTP id af79cd13be357-949b35acb46mr4508868785a.17.1795798478992;
        Fri, 27 Nov 2026 08:54:38 -0800 (PST)
X-Received: by 2002:a05:620a:408b:b0:949:3cfa:8592 with SMTP id af79cd13be357-949b35acb46mr4508853685a.17.1795798476844;
        Fri, 27 Nov 2026 08:54:36 -0800 (PST)
Received: from toster.lan ([185.228.162.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110ba3sm39587589f8f.35.2026.11.27.08.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 08:54:35 -0800 (PST)
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [RFC meta-security][PATCH] Move meta-security main layer into a sub-layer
Date: Fri, 27 Nov 2026 16:54:25 +0000
Message-ID: <20261127165425.726917-1-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2NyBTYWx0ZWRfX53ECUjA2O1xt
 UmebZIVNwdl5miFRdvLjeV2jFihLSUmM3ep2PMq8pIII/P8o37gzNAOaUt6siOyEVPeoEL5MsTN
 dRSGSAwnAakw/P8pyRDR/faeEsdpbI4=
X-Proofpoint-GUID: z5ZfVVg4qk7avQfKZHspabekqLjizWY1
X-Proofpoint-ORIG-GUID: z5ZfVVg4qk7avQfKZHspabekqLjizWY1
X-Authority-Analysis: v=2.4 cv=M9fYuCws c=1 sm=1 tr=0 ts=6b09b5d2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=qOKIifoFPMYe9XV0Ag7/Dg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=7M5xO3U2WEnr7_rMBFIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2NyBTYWx0ZWRfX/lccbtgQ16fc
 XwQWodU2ulQhEqyPLyRnndkpkWoG2sT4RzA1tn9NJLRo6FlgKpnuIenFFRYvGqHj5ytOsP/uhlg
 8TLfsQmQt84W6Y9Q/1E5tFf9ezOIMfnZdtXmDz6OkbqXHQjrA0ZKYQq9AJOfOwyJZmH0VYMkcpS
 ygVy8E2aaz2LW1dAMOOY9I8Dg/Tymf6M56vX3GzMpaZBQqwfC9LCdH+HUH9hPK+87UBJNGBRCXH
 Q1WUKfa5MJZ8TNcX4Ebg5spv+lFNqHpqD4yFaIE7CM5XUzaHELY+CG2dvDJDsV+ncdR89VIAFer
 +Iy/qDjINYQAJNU5ry8rdxK8gw4+3o+E7EVsZDxhHZQjsGSPcGU7K0brijHvHIGSfgkH3cSzgU+
 kM/tONEt5iJTY44qlN7Zligv7d1svzkYsn6bwQtMF5/FXoTzYM07mqKfeevF/ndPKeDqj9Nr/wf
 D89NNxgHvQG5EsiuuqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270067
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0031df01.pphosted.com id 6ARFp9JV2617606
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Nov 2026 16:54:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5553

With the new layer configuration bitbake will refuses nested layers.
The meta-security=E2=80=99s top-level layer contains all the other layers=
 inside.

To avoid nested layers, we'll create a sublayer for the top level.
Creating a sublayer for the main layer solves the problem and is a
simple change that only change the layer=E2=80=99s path.
There are no functional changes other than the relocation to the
new sub-layer path.

Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 README.md                                                       | 2 +-
 kas/kas-security-base.yml                                       | 2 +-
 {classes =3D> meta-security/classes}/aide-base.bbclass            | 0
 {classes =3D> meta-security/classes}/aide-db-init.bbclass         | 0
 {classes =3D> meta-security/classes}/check_security.bbclass       | 0
 {classes =3D> meta-security/classes}/dm-verity-img.bbclass        | 0
 {classes =3D> meta-security/classes}/sanity-meta-security.bbclass | 0
 .../conf}/distro/include/maintainers-meta-security.inc          | 0
 {conf =3D> meta-security/conf}/layer.conf                         | 0
 .../packagegroup/packagegroup-core-security.bbappend            | 0
 .../recipes-scanners/checksecurity/checksecurity_2.0.16.bb      | 0
 .../files/check-setuid-use-more-portable-find-args.patch        | 0
 .../meta-perl/recipes-security/bastille/bastille_3.2.1.bb       | 0
 .../meta-perl/recipes-security/bastille/files/API.pm            | 0
 .../recipes-security/bastille/files/AccountPermission.pm        | 0
 .../meta-perl/recipes-security/bastille/files/FileContent.pm    | 0
 .../meta-perl/recipes-security/bastille/files/HPSpecific.pm     | 0
 .../meta-perl/recipes-security/bastille/files/Miscellaneous.pm  | 0
 .../meta-perl/recipes-security/bastille/files/ServiceAdmin.pm   | 0
 .../bastille/files/accept_os_flag_in_backend.patch              | 0
 .../recipes-security/bastille/files/allow_os_with_assess.patch  | 0
 .../recipes-security/bastille/files/call_output_config.patch    | 0
 .../meta-perl/recipes-security/bastille/files/config            | 0
 .../recipes-security/bastille/files/do_not_apply_config.patch   | 0
 .../recipes-security/bastille/files/edit_usage_message.patch    | 0
 .../recipes-security/bastille/files/find_existing_config.patch  | 0
 .../bastille/files/fix_missing_use_directives.patch             | 0
 .../recipes-security/bastille/files/fix_number_of_modules.patch | 0
 .../recipes-security/bastille/files/fix_version_parse.patch     | 0
 .../bastille/files/fixed_defined_warnings.patch                 | 0
 .../bastille/files/organize_distro_discovery.patch              | 0
 .../bastille/files/remove_questions_text_file_references.patch  | 0
 .../recipes-security/bastille/files/set_required_questions.py   | 0
 .../recipes-security/bastille/files/simplify_B_place.patch      | 0
 .../bastille/files/upgrade_options_processing.patch             | 0
 .../meta-perl/recipes-security/nikto/files/location.patch       | 0
 .../meta-perl/recipes-security/nikto/nikto_2.1.6.bb             | 0
 .../packagegroup/packagegroup-core-security.bbappend            | 0
 .../recipes-devtools/python/python3-flask-script_2.0.6.bb       | 0
 .../recipes-devtools/python/python3-json2html_1.3.0.bb          | 0
 .../0001-Make-asyncore-support-optional-for-Python-3.patch      | 0
 .../recipes-devtools/python/python3-pyinotify_0.9.6.bb          | 0
 .../meta-python/recipes-devtools/python/python3-segno_1.5.2.bb  | 0
 .../recipes-devtools/python/python3-xmldiff_2.7.0.bb            | 0
 .../recipes-devtools/python/python3-yamlpath_3.8.2.bb           | 0
 ...1-fail2ban-use-putao.unittest.TestRunner-for-ptest-out.patch | 0
 .../meta-python/recipes-security/fail2ban/files/initd           | 0
 .../meta-python/recipes-security/fail2ban/files/run-ptest       | 0
 .../recipes-security/fail2ban/python3-fail2ban_git.bb           | 0
 .../recipes-security/mfa/python3-privacyidea_3.9.1.bb           | 0
 .../recipes-security/python/python3-oauth2client_4.1.3.bb       | 0
 .../packagegroup/packagegroup-core-security.bbappend            | 0
 .../recipes-security/sssd/files/drop_ntpdate_chk.patch          | 0
 .../recipes-security/sssd/files/fix-ldblibdir.patch             | 0
 .../networking-layer/recipes-security/sssd/files/fix_gid.patch  | 0
 .../recipes-security/sssd/files/musl_fixup.patch                | 0
 .../networking-layer/recipes-security/sssd/files/no_gen.patch   | 0
 .../networking-layer/recipes-security/sssd/files/sssd.conf      | 0
 .../networking-layer/recipes-security/sssd/sssd_2.13.1.bb       | 0
 .../files}/wic/beaglebone-yocto-verity.wks.in                   | 0
 .../files}/wic/systemd-bootdisk-dmverity-hash.wks.in            | 0
 .../files}/wic/systemd-bootdisk-dmverity.wks.in                 | 0
 {lib =3D> meta-security/lib}/oeqa/runtime/cases/aide.py           | 0
 {lib =3D> meta-security/lib}/oeqa/runtime/cases/apparmor.py       | 0
 {lib =3D> meta-security/lib}/oeqa/runtime/cases/checksec.py       | 0
 {lib =3D> meta-security/lib}/oeqa/runtime/cases/clamav.py         | 0
 {lib =3D> meta-security/lib}/oeqa/runtime/cases/firejail.py       | 0
 {lib =3D> meta-security/lib}/oeqa/runtime/cases/openscap.py       | 0
 {lib =3D> meta-security/lib}/oeqa/runtime/cases/samhain.py        | 0
 {lib =3D> meta-security/lib}/oeqa/runtime/cases/smack.py          | 0
 {lib =3D> meta-security/lib}/oeqa/runtime/cases/sssd.py           | 0
 {lib =3D> meta-security/lib}/oeqa/runtime/cases/suricata.py       | 0
 {lib =3D> meta-security/lib}/oeqa/selftest/cases/cvechecker.py    | 0
 .../recipes-compliance}/lynis/lynis_3.1.7.bb                    | 0
 ...1-CMakeLists.txt-fix-installation-directory-for-system.patch | 0
 ...2-Replace-removed-Python-2-C-API-macros-for-SWIG-4.5.0.patch | 0
 .../recipes-compliance}/openscap/openscap_1.4.4.bb              | 0
 .../recipes-compliance}/scap-security-guide/files/run_eval.sh   | 0
 .../scap-security-guide/scap-security-guide_0.1.81.bb           | 0
 .../recipes-core}/images/dm-verity-image-initramfs.bb           | 0
 .../recipes-core}/images/security-build-image.bb                | 0
 .../recipes-core}/images/security-client-image.bb               | 0
 .../recipes-core}/images/security-server-image.bb               | 0
 .../recipes-core}/images/security-test-image.bb                 | 0
 .../recipes-core}/initrdscripts/initramfs-framework-dm/dmverity | 0
 .../recipes-core}/initrdscripts/initramfs-framework.inc         | 0
 .../initrdscripts/initramfs-framework_1.0.bbappend              | 0
 .../recipes-core}/packagegroup/packagegroup-core-security.bb    | 0
 .../recipes-ids}/aide/aide/0001-Fixes-build-issues.patch        | 0
 {recipes-ids =3D> meta-security/recipes-ids}/aide/aide/aide.conf  | 0
 {recipes-ids =3D> meta-security/recipes-ids}/aide/aide_0.19.4.bb  | 0
 .../recipes-ids}/crowdsec/crowdsec-go-mods.inc                  | 0
 .../recipes-ids}/crowdsec/crowdsec-licenses.inc                 | 0
 .../recipes-ids}/crowdsec/crowdsec_1.8.1.bb                     | 0
 .../ossec/files/0001-Makefile-drop-running-scrips-install.patch | 0
 .../ossec/files/0002-Makefile-don-t-set-uid-gid.patch           | 0
 .../recipes-ids}/ossec/files/0003-Add-OpenSSL-4.0-support.patch | 0
 .../recipes-ids}/ossec/ossec-hids_4.3.0.bb                      | 0
 .../0001-Format-test-output-to-match-Automake-standards.patch   | 0
 .../samhain/files/0001-Hash-fix-for-MIPS64-and-AARCH64.patch    | 0
 .../samhain/files/0002-Make-samhainrc-OE-friendly.patch         | 0
 .../samhain/files/0003-fix-real-path-for-some-files-dirs.patch  | 0
 .../files/0004-Set-the-PID-Lock-path-for-samhain.pid.patch      | 0
 .../samhain/files/0005-Fix-sha256-for-big-endian-machines.patch | 0
 .../samhain/files/0006-configure-add-option-for-ps.patch        | 0
 .../0007-configure.ac-avoid-searching-host-for-postgresql.patch | 0
 ...0008-Add-LDFLAGS-variable-for-compiling-samhain_setpwd.patch | 0
 .../samhain/files/0009-fix-build-with-new-version-attr.patch    | 0
 .../files/0010-Fix-initializer-element-is-not-constant.patch    | 0
 ...1-not-run-test-on-host-since-we-are-doing-cross-compil.patch | 0
 .../samhain/files/0012-Don-t-expose-configure-args.patch        | 0
 .../files/0013-yulerc-set-SetLockfilePath-to-run-yule.pid.patch | 0
 .../recipes-ids}/samhain/files/run-ptest                        | 0
 .../recipes-ids}/samhain/files/samhain-client.default           | 0
 .../recipes-ids}/samhain/files/samhain-client.init              | 0
 .../recipes-ids}/samhain/files/samhain-server-volatiles         | 0
 .../recipes-ids}/samhain/files/samhain-server-volatiles.conf    | 0
 .../recipes-ids}/samhain/files/samhain-server.default           | 0
 .../recipes-ids}/samhain/files/samhain-server.init              | 0
 .../recipes-ids}/samhain/files/samhain-standalone.default       | 0
 .../recipes-ids}/samhain/files/samhain-standalone.init          | 0
 .../recipes-ids}/samhain/files/samhain.service                  | 0
 .../recipes-ids}/samhain/samhain-client.bb                      | 0
 .../recipes-ids}/samhain/samhain-server.bb                      | 0
 .../recipes-ids}/samhain/samhain-standalone.bb                  | 0
 {recipes-ids =3D> meta-security/recipes-ids}/samhain/samhain.inc  | 0
 .../0001-Skip-pkg-Makefile-from-using-its-own-rust-steps.patch  | 0
 .../recipes-ids}/suricata/files/run-ptest                       | 0
 .../recipes-ids}/suricata/files/suricata.service                | 0
 .../recipes-ids}/suricata/files/suricata.yaml                   | 0
 .../recipes-ids}/suricata/files/tmpfiles.suricata               | 0
 .../recipes-ids}/suricata/files/volatiles.03_suricata           | 0
 .../recipes-ids}/suricata/python3-suricata-update_1.3.6.bb      | 0
 .../recipes-ids}/suricata/suricata-crates.inc                   | 0
 .../recipes-ids}/suricata/suricata.inc                          | 0
 .../recipes-ids}/suricata/suricata_8.0.6.bb                     | 0
 .../recipes-kernel}/linux/files/lkrg.cfg                        | 0
 .../recipes-kernel}/linux/files/lkrg.scc                        | 0
 .../recipes-kernel}/linux/linux-yocto-rt_%.bbappend             | 0
 .../recipes-kernel}/linux/linux-yocto_%.bbappend                | 0
 .../recipes-kernel}/linux/linux-yocto_security.inc              | 0
 .../recipes-kernel}/lkrg/lkrg-module_0.9.7.bb                   | 0
 .../recipes-mac}/AppArmor/apparmor_4.0.3.bb                     | 0
 .../0001-Makefile-fix-hardcoded-installation-directories.patch  | 0
 .../files/0001-Makefile.am-suppress-perllocal.pod.patch         | 0
 .../AppArmor/files/0001-fail.py-handle-missing-cgitb.patch      | 0
 .../AppArmor/files/crosscompile_perl_bindings.patch             | 0
 .../recipes-mac}/AppArmor/files/run-ptest                       | 0
 {recipes-mac =3D> meta-security/recipes-mac}/ccs-tools/README     | 0
 .../recipes-mac}/ccs-tools/ccs-tools_1.8.14.bb                  | 0
 .../recipes-mac}/smack/mmap-smack-test/mmap.c                   | 0
 .../recipes-mac}/smack/mmap-smack-test_1.0.bb                   | 0
 .../recipes-mac}/smack/smack-test/notroot.py                    | 0
 .../recipes-mac}/smack/smack-test/smack_test_file_access.sh     | 0
 .../smack/smack-test/test_privileged_change_self_label.sh       | 0
 .../recipes-mac}/smack/smack-test/test_smack_onlycap.sh         | 0
 .../recipes-mac}/smack/smack-test_1.0.bb                        | 0
 .../recipes-mac}/smack/smack/run-ptest                          | 0
 .../recipes-mac}/smack/smack/smack_generator_make_fixup.patch   | 0
 {recipes-mac =3D> meta-security/recipes-mac}/smack/smack_1.3.1.bb | 0
 .../recipes-mac}/smack/tcp-smack-test/tcp_client.c              | 0
 .../recipes-mac}/smack/tcp-smack-test/tcp_server.c              | 0
 .../recipes-mac}/smack/tcp-smack-test/test_smack_tcp_sockets.sh | 0
 .../recipes-mac}/smack/tcp-smack-test_1.0.bb                    | 0
 .../recipes-mac}/smack/udp-smack-test/test_smack_udp_sockets.sh | 0
 .../recipes-mac}/smack/udp-smack-test/udp_client.c              | 0
 .../recipes-mac}/smack/udp-smack-test/udp_server.c              | 0
 .../recipes-mac}/smack/udp-smack-test_1.0.bb                    | 0
 .../recipes-perl}/perl/files/libwhisker2.patch                  | 0
 .../recipes-perl}/perl/lib-perl_0.63.bb                         | 0
 .../recipes-perl}/perl/libwhisker2-perl_2.5.bb                  | 0
 .../recipes-scanners}/arpwatch/arpwatch_3.3.bb                  | 0
 .../recipes-scanners}/arpwatch/files/arpwatch.conf              | 0
 .../recipes-scanners}/arpwatch/files/arpwatch.default           | 0
 .../recipes-scanners}/arpwatch/files/arpwatch_init              | 0
 .../recipes-scanners}/arpwatch/files/host_contam_fix.patch      | 0
 .../recipes-scanners}/buck-security/buck-security_0.7.bb        | 0
 .../recipes-scanners}/checksec/checksec_2.6.0.bb                | 0
 .../recipes-scanners}/clamav/clamav-crates.inc                  | 0
 .../recipes-scanners}/clamav/clamav-git-crates.inc              | 0
 .../recipes-scanners}/clamav/clamav_1.5.4.bb                    | 0
 ...1-Use-non-deprecated-OpenSSL-accessors-for-ASN1_STRING.patch | 0
 .../recipes-scanners}/clamav/files/clamav-freshclam.service     | 0
 .../recipes-scanners}/clamav/files/clamav-milter.conf.sample    | 0
 .../recipes-scanners}/clamav/files/clamav.service               | 0
 .../recipes-scanners}/clamav/files/clamd.conf                   | 0
 .../recipes-scanners}/clamav/files/freshclam-native.conf        | 0
 .../recipes-scanners}/clamav/files/freshclam.conf               | 0
 .../recipes-scanners}/clamav/files/tmpfiles.clamav              | 0
 .../recipes-scanners}/clamav/files/volatiles.03_clamav          | 0
 .../recipes-scanners}/rootkits/chkrootkit_0.58b.bb              | 0
 .../rootkits/files/0001-Fix-building-with-gcc-15.patch          | 0
 .../recipes-scanners}/rootkits/files/musl_fix.patch             | 0
 .../Firejail/firejail/exclude_seccomp_util_compiles.patch       | 0
 .../recipes-security}/Firejail/firejail_0.9.72.bb               | 0
 .../aircrack-ng/0001-Remove-build-directory-reference.patch     | 0
 .../recipes-security}/aircrack-ng/aircrack-ng_1.7.bb            | 0
 .../recipes-security}/chipsec/chipsec_1.13.16.bb                | 0
 .../recipes-security}/cryptmount/cryptmount_6.2.0.bb            | 0
 .../recipes-security}/ding-libs/ding-libs_0.7.0.bb              | 0
 .../recipes-security}/ecryptfs-utils/ecryptfs-utils_111.bb      | 0
 .../ecryptfs-utils/files/0001-avoid-race-condition.patch        | 0
 .../ecryptfs-utils/files/define_musl_sword_type.patch           | 0
 .../ecryptfs-utils/files/ecryptfs-utils-CVE-2016-6224.patch     | 0
 .../recipes-security}/ecryptfs-utils/files/ecryptfs.service     | 0
 .../recipes-security}/fscrypt/fscrypt_1.1.0.bb                  | 0
 .../recipes-security}/fscryptctl/fscryptctl_1.1.0.bb            | 0
 .../recipes-security}/glome/glome_git.bb                        | 0
 .../google-authenticator-libpam_1.11.bb                         | 0
 .../recipes-security}/isic/files/configure_fix.patch            | 0
 .../recipes-security}/isic/files/isic-0.07-make.patch           | 0
 .../recipes-security}/isic/files/isic-0.07-netinet.patch        | 0
 .../recipes-security}/isic/isic_0.07.bb                         | 0
 .../krill/files/0001-Disable-abort-on-panic.patch               | 0
 .../krill/files/0002-Update-crate-dependencies.patch            | 0
 .../recipes-security}/krill/krill-crates.inc                    | 0
 .../recipes-security}/krill/krill_0.16.0.bb                     | 0
 .../recipes-security}/libgssglue/files/run-ptest                | 0
 .../recipes-security}/libgssglue/libgssglue_0.9.bb              | 0
 .../ncrack/ncrack/0001-fix-ftbfs-with-OpenSSL-4.patch           | 0
 .../recipes-security}/ncrack/ncrack_0.7.bb                      | 0
 .../files/0001-Fix-implicit-function-declarations.patch         | 0
 .../opendnssec/files/0001-include-utilities.h.patch             | 0
 .../files/0002-reorder-header-files-and-include-time.h.patch    | 0
 .../recipes-security}/opendnssec/files/libdns_conf_fix.patch    | 0
 .../recipes-security}/opendnssec/files/libxml2_conf.patch       | 0
 .../recipes-security}/opendnssec/opendnssec_2.1.14.bb           | 0
 .../recipes-security}/redhat-security/files/find-chroot-py.sh   | 0
 .../recipes-security}/redhat-security/files/find-chroot.sh      | 0
 .../recipes-security}/redhat-security/files/find-elf4tmp.sh     | 0
 .../recipes-security}/redhat-security/files/find-execstack.sh   | 0
 .../recipes-security}/redhat-security/files/find-hidden-exec.sh | 0
 .../redhat-security/files/find-nodrop-groups.sh                 | 0
 .../recipes-security}/redhat-security/files/find-sh4errors.sh   | 0
 .../recipes-security}/redhat-security/files/find-sh4tmp.sh      | 0
 .../recipes-security}/redhat-security/files/lib-bin-check.sh    | 0
 .../recipes-security}/redhat-security/files/rpm-chksec.sh       | 0
 .../recipes-security}/redhat-security/files/rpm-drop-groups.sh  | 0
 .../redhat-security/files/selinux-check-devices.sh              | 0
 .../redhat-security/files/selinux-ls-unconfined.sh              | 0
 .../recipes-security}/redhat-security/redhat-security_1.0.bb    | 0
 .../recipes-security}/sshguard/sshguard_2.5.1.bb                | 0
 {scripts =3D> meta-security/scripts}/ci-cleanup.sh                | 0
 {scripts =3D> meta-security/scripts}/upload-error-report          | 0
 244 files changed, 2 insertions(+), 2 deletions(-)
 rename {classes =3D> meta-security/classes}/aide-base.bbclass (100%)
 rename {classes =3D> meta-security/classes}/aide-db-init.bbclass (100%)
 rename {classes =3D> meta-security/classes}/check_security.bbclass (100%=
)
 rename {classes =3D> meta-security/classes}/dm-verity-img.bbclass (100%)
 rename {classes =3D> meta-security/classes}/sanity-meta-security.bbclass=
 (100%)
 rename {conf =3D> meta-security/conf}/distro/include/maintainers-meta-se=
curity.inc (100%)
 rename {conf =3D> meta-security/conf}/layer.conf (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-core/packagegroup/packagegroup-core-security.bbappend (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-scanners/checksecurity/checksecurity_2.0.16.bb (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-scanners/checksecurity/files/check-setuid-use-more-portable-find-args=
.patch (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-security/bastille/bastille_3.2.1.bb (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-security/bastille/files/API.pm (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-security/bastille/files/AccountPermission.pm (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-security/bastille/files/FileContent.pm (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-security/bastille/files/HPSpecific.pm (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-security/bastille/files/Miscellaneous.pm (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-security/bastille/files/ServiceAdmin.pm (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-security/bastille/files/accept_os_flag_in_backend.patch (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-security/bastille/files/allow_os_with_assess.patch (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-security/bastille/files/call_output_config.patch (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-security/bastille/files/config (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-security/bastille/files/do_not_apply_config.patch (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-security/bastille/files/edit_usage_message.patch (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-security/bastille/files/find_existing_config.patch (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-security/bastille/files/fix_missing_use_directives.patch (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-security/bastille/files/fix_number_of_modules.patch (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-security/bastille/files/fix_version_parse.patch (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-security/bastille/files/fixed_defined_warnings.patch (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-security/bastille/files/organize_distro_discovery.patch (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-security/bastille/files/remove_questions_text_file_references.patch (=
100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-security/bastille/files/set_required_questions.py (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-security/bastille/files/simplify_B_place.patch (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-security/bastille/files/upgrade_options_processing.patch (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-security/nikto/files/location.patch (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-perl/reci=
pes-security/nikto/nikto_2.1.6.bb (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-python/re=
cipes-core/packagegroup/packagegroup-core-security.bbappend (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-python/re=
cipes-devtools/python/python3-flask-script_2.0.6.bb (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-python/re=
cipes-devtools/python/python3-json2html_1.3.0.bb (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-python/re=
cipes-devtools/python/python3-pyinotify/0001-Make-asyncore-support-option=
al-for-Python-3.patch (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-python/re=
cipes-devtools/python/python3-pyinotify_0.9.6.bb (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-python/re=
cipes-devtools/python/python3-segno_1.5.2.bb (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-python/re=
cipes-devtools/python/python3-xmldiff_2.7.0.bb (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-python/re=
cipes-devtools/python/python3-yamlpath_3.8.2.bb (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-python/re=
cipes-security/fail2ban/files/0001-fail2ban-use-putao.unittest.TestRunner=
-for-ptest-out.patch (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-python/re=
cipes-security/fail2ban/files/initd (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-python/re=
cipes-security/fail2ban/files/run-ptest (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-python/re=
cipes-security/fail2ban/python3-fail2ban_git.bb (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-python/re=
cipes-security/mfa/python3-privacyidea_3.9.1.bb (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/meta-python/re=
cipes-security/python/python3-oauth2client_4.1.3.bb (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/networking-lay=
er/recipes-core/packagegroup/packagegroup-core-security.bbappend (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/networking-lay=
er/recipes-security/sssd/files/drop_ntpdate_chk.patch (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/networking-lay=
er/recipes-security/sssd/files/fix-ldblibdir.patch (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/networking-lay=
er/recipes-security/sssd/files/fix_gid.patch (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/networking-lay=
er/recipes-security/sssd/files/musl_fixup.patch (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/networking-lay=
er/recipes-security/sssd/files/no_gen.patch (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/networking-lay=
er/recipes-security/sssd/files/sssd.conf (100%)
 rename {dynamic-layers =3D> meta-security/dynamic-layers}/networking-lay=
er/recipes-security/sssd/sssd_2.13.1.bb (100%)
 rename {files =3D> meta-security/files}/wic/beaglebone-yocto-verity.wks.=
in (100%)
 rename {files =3D> meta-security/files}/wic/systemd-bootdisk-dmverity-ha=
sh.wks.in (100%)
 rename {files =3D> meta-security/files}/wic/systemd-bootdisk-dmverity.wk=
s.in (100%)
 rename {lib =3D> meta-security/lib}/oeqa/runtime/cases/aide.py (100%)
 rename {lib =3D> meta-security/lib}/oeqa/runtime/cases/apparmor.py (100%=
)
 rename {lib =3D> meta-security/lib}/oeqa/runtime/cases/checksec.py (100%=
)
 rename {lib =3D> meta-security/lib}/oeqa/runtime/cases/clamav.py (100%)
 rename {lib =3D> meta-security/lib}/oeqa/runtime/cases/firejail.py (100%=
)
 rename {lib =3D> meta-security/lib}/oeqa/runtime/cases/openscap.py (100%=
)
 rename {lib =3D> meta-security/lib}/oeqa/runtime/cases/samhain.py (100%)
 rename {lib =3D> meta-security/lib}/oeqa/runtime/cases/smack.py (100%)
 rename {lib =3D> meta-security/lib}/oeqa/runtime/cases/sssd.py (100%)
 rename {lib =3D> meta-security/lib}/oeqa/runtime/cases/suricata.py (100%=
)
 rename {lib =3D> meta-security/lib}/oeqa/selftest/cases/cvechecker.py (1=
00%)
 rename {recipes-compliance =3D> meta-security/recipes-compliance}/lynis/=
lynis_3.1.7.bb (100%)
 rename {recipes-compliance =3D> meta-security/recipes-compliance}/opensc=
ap/files/0001-CMakeLists.txt-fix-installation-directory-for-system.patch =
(100%)
 rename {recipes-compliance =3D> meta-security/recipes-compliance}/opensc=
ap/files/0002-Replace-removed-Python-2-C-API-macros-for-SWIG-4.5.0.patch =
(100%)
 rename {recipes-compliance =3D> meta-security/recipes-compliance}/opensc=
ap/openscap_1.4.4.bb (100%)
 rename {recipes-compliance =3D> meta-security/recipes-compliance}/scap-s=
ecurity-guide/files/run_eval.sh (100%)
 rename {recipes-compliance =3D> meta-security/recipes-compliance}/scap-s=
ecurity-guide/scap-security-guide_0.1.81.bb (100%)
 rename {recipes-core =3D> meta-security/recipes-core}/images/dm-verity-i=
mage-initramfs.bb (100%)
 rename {recipes-core =3D> meta-security/recipes-core}/images/security-bu=
ild-image.bb (100%)
 rename {recipes-core =3D> meta-security/recipes-core}/images/security-cl=
ient-image.bb (100%)
 rename {recipes-core =3D> meta-security/recipes-core}/images/security-se=
rver-image.bb (100%)
 rename {recipes-core =3D> meta-security/recipes-core}/images/security-te=
st-image.bb (100%)
 rename {recipes-core =3D> meta-security/recipes-core}/initrdscripts/init=
ramfs-framework-dm/dmverity (100%)
 rename {recipes-core =3D> meta-security/recipes-core}/initrdscripts/init=
ramfs-framework.inc (100%)
 rename {recipes-core =3D> meta-security/recipes-core}/initrdscripts/init=
ramfs-framework_1.0.bbappend (100%)
 rename {recipes-core =3D> meta-security/recipes-core}/packagegroup/packa=
gegroup-core-security.bb (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/aide/aide/0001-Fixes=
-build-issues.patch (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/aide/aide/aide.conf =
(100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/aide/aide_0.19.4.bb =
(100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/crowdsec/crowdsec-go=
-mods.inc (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/crowdsec/crowdsec-li=
censes.inc (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/crowdsec/crowdsec_1.=
8.1.bb (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/ossec/files/0001-Mak=
efile-drop-running-scrips-install.patch (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/ossec/files/0002-Mak=
efile-don-t-set-uid-gid.patch (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/ossec/files/0003-Add=
-OpenSSL-4.0-support.patch (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/ossec/ossec-hids_4.3=
.0.bb (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/files/0001-F=
ormat-test-output-to-match-Automake-standards.patch (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/files/0001-H=
ash-fix-for-MIPS64-and-AARCH64.patch (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/files/0002-M=
ake-samhainrc-OE-friendly.patch (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/files/0003-f=
ix-real-path-for-some-files-dirs.patch (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/files/0004-S=
et-the-PID-Lock-path-for-samhain.pid.patch (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/files/0005-F=
ix-sha256-for-big-endian-machines.patch (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/files/0006-c=
onfigure-add-option-for-ps.patch (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/files/0007-c=
onfigure.ac-avoid-searching-host-for-postgresql.patch (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/files/0008-A=
dd-LDFLAGS-variable-for-compiling-samhain_setpwd.patch (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/files/0009-f=
ix-build-with-new-version-attr.patch (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/files/0010-F=
ix-initializer-element-is-not-constant.patch (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/files/0011-n=
ot-run-test-on-host-since-we-are-doing-cross-compil.patch (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/files/0012-D=
on-t-expose-configure-args.patch (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/files/0013-y=
ulerc-set-SetLockfilePath-to-run-yule.pid.patch (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/files/run-pt=
est (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/files/samhai=
n-client.default (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/files/samhai=
n-client.init (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/files/samhai=
n-server-volatiles (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/files/samhai=
n-server-volatiles.conf (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/files/samhai=
n-server.default (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/files/samhai=
n-server.init (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/files/samhai=
n-standalone.default (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/files/samhai=
n-standalone.init (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/files/samhai=
n.service (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/samhain-clie=
nt.bb (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/samhain-serv=
er.bb (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/samhain-stan=
dalone.bb (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/samhain/samhain.inc =
(100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/suricata/files/0001-=
Skip-pkg-Makefile-from-using-its-own-rust-steps.patch (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/suricata/files/run-p=
test (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/suricata/files/suric=
ata.service (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/suricata/files/suric=
ata.yaml (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/suricata/files/tmpfi=
les.suricata (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/suricata/files/volat=
iles.03_suricata (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/suricata/python3-sur=
icata-update_1.3.6.bb (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/suricata/suricata-cr=
ates.inc (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/suricata/suricata.in=
c (100%)
 rename {recipes-ids =3D> meta-security/recipes-ids}/suricata/suricata_8.=
0.6.bb (100%)
 rename {recipes-kernel =3D> meta-security/recipes-kernel}/linux/files/lk=
rg.cfg (100%)
 rename {recipes-kernel =3D> meta-security/recipes-kernel}/linux/files/lk=
rg.scc (100%)
 rename {recipes-kernel =3D> meta-security/recipes-kernel}/linux/linux-yo=
cto-rt_%.bbappend (100%)
 rename {recipes-kernel =3D> meta-security/recipes-kernel}/linux/linux-yo=
cto_%.bbappend (100%)
 rename {recipes-kernel =3D> meta-security/recipes-kernel}/linux/linux-yo=
cto_security.inc (100%)
 rename {recipes-kernel =3D> meta-security/recipes-kernel}/lkrg/lkrg-modu=
le_0.9.7.bb (100%)
 rename {recipes-mac =3D> meta-security/recipes-mac}/AppArmor/apparmor_4.=
0.3.bb (100%)
 rename {recipes-mac =3D> meta-security/recipes-mac}/AppArmor/files/0001-=
Makefile-fix-hardcoded-installation-directories.patch (100%)
 rename {recipes-mac =3D> meta-security/recipes-mac}/AppArmor/files/0001-=
Makefile.am-suppress-perllocal.pod.patch (100%)
 rename {recipes-mac =3D> meta-security/recipes-mac}/AppArmor/files/0001-=
fail.py-handle-missing-cgitb.patch (100%)
 rename {recipes-mac =3D> meta-security/recipes-mac}/AppArmor/files/cross=
compile_perl_bindings.patch (100%)
 rename {recipes-mac =3D> meta-security/recipes-mac}/AppArmor/files/run-p=
test (100%)
 rename {recipes-mac =3D> meta-security/recipes-mac}/ccs-tools/README (10=
0%)
 rename {recipes-mac =3D> meta-security/recipes-mac}/ccs-tools/ccs-tools_=
1.8.14.bb (100%)
 rename {recipes-mac =3D> meta-security/recipes-mac}/smack/mmap-smack-tes=
t/mmap.c (100%)
 rename {recipes-mac =3D> meta-security/recipes-mac}/smack/mmap-smack-tes=
t_1.0.bb (100%)
 rename {recipes-mac =3D> meta-security/recipes-mac}/smack/smack-test/not=
root.py (100%)
 rename {recipes-mac =3D> meta-security/recipes-mac}/smack/smack-test/sma=
ck_test_file_access.sh (100%)
 rename {recipes-mac =3D> meta-security/recipes-mac}/smack/smack-test/tes=
t_privileged_change_self_label.sh (100%)
 rename {recipes-mac =3D> meta-security/recipes-mac}/smack/smack-test/tes=
t_smack_onlycap.sh (100%)
 rename {recipes-mac =3D> meta-security/recipes-mac}/smack/smack-test_1.0=
.bb (100%)
 rename {recipes-mac =3D> meta-security/recipes-mac}/smack/smack/run-ptes=
t (100%)
 rename {recipes-mac =3D> meta-security/recipes-mac}/smack/smack/smack_ge=
nerator_make_fixup.patch (100%)
 rename {recipes-mac =3D> meta-security/recipes-mac}/smack/smack_1.3.1.bb=
 (100%)
 rename {recipes-mac =3D> meta-security/recipes-mac}/smack/tcp-smack-test=
/tcp_client.c (100%)
 rename {recipes-mac =3D> meta-security/recipes-mac}/smack/tcp-smack-test=
/tcp_server.c (100%)
 rename {recipes-mac =3D> meta-security/recipes-mac}/smack/tcp-smack-test=
/test_smack_tcp_sockets.sh (100%)
 rename {recipes-mac =3D> meta-security/recipes-mac}/smack/tcp-smack-test=
_1.0.bb (100%)
 rename {recipes-mac =3D> meta-security/recipes-mac}/smack/udp-smack-test=
/test_smack_udp_sockets.sh (100%)
 rename {recipes-mac =3D> meta-security/recipes-mac}/smack/udp-smack-test=
/udp_client.c (100%)
 rename {recipes-mac =3D> meta-security/recipes-mac}/smack/udp-smack-test=
/udp_server.c (100%)
 rename {recipes-mac =3D> meta-security/recipes-mac}/smack/udp-smack-test=
_1.0.bb (100%)
 rename {recipes-perl =3D> meta-security/recipes-perl}/perl/files/libwhis=
ker2.patch (100%)
 rename {recipes-perl =3D> meta-security/recipes-perl}/perl/lib-perl_0.63=
.bb (100%)
 rename {recipes-perl =3D> meta-security/recipes-perl}/perl/libwhisker2-p=
erl_2.5.bb (100%)
 rename {recipes-scanners =3D> meta-security/recipes-scanners}/arpwatch/a=
rpwatch_3.3.bb (100%)
 rename {recipes-scanners =3D> meta-security/recipes-scanners}/arpwatch/f=
iles/arpwatch.conf (100%)
 rename {recipes-scanners =3D> meta-security/recipes-scanners}/arpwatch/f=
iles/arpwatch.default (100%)
 rename {recipes-scanners =3D> meta-security/recipes-scanners}/arpwatch/f=
iles/arpwatch_init (100%)
 rename {recipes-scanners =3D> meta-security/recipes-scanners}/arpwatch/f=
iles/host_contam_fix.patch (100%)
 rename {recipes-scanners =3D> meta-security/recipes-scanners}/buck-secur=
ity/buck-security_0.7.bb (100%)
 rename {recipes-scanners =3D> meta-security/recipes-scanners}/checksec/c=
hecksec_2.6.0.bb (100%)
 rename {recipes-scanners =3D> meta-security/recipes-scanners}/clamav/cla=
mav-crates.inc (100%)
 rename {recipes-scanners =3D> meta-security/recipes-scanners}/clamav/cla=
mav-git-crates.inc (100%)
 rename {recipes-scanners =3D> meta-security/recipes-scanners}/clamav/cla=
mav_1.5.4.bb (100%)
 rename {recipes-scanners =3D> meta-security/recipes-scanners}/clamav/fil=
es/0001-Use-non-deprecated-OpenSSL-accessors-for-ASN1_STRING.patch (100%)
 rename {recipes-scanners =3D> meta-security/recipes-scanners}/clamav/fil=
es/clamav-freshclam.service (100%)
 rename {recipes-scanners =3D> meta-security/recipes-scanners}/clamav/fil=
es/clamav-milter.conf.sample (100%)
 rename {recipes-scanners =3D> meta-security/recipes-scanners}/clamav/fil=
es/clamav.service (100%)
 rename {recipes-scanners =3D> meta-security/recipes-scanners}/clamav/fil=
es/clamd.conf (100%)
 rename {recipes-scanners =3D> meta-security/recipes-scanners}/clamav/fil=
es/freshclam-native.conf (100%)
 rename {recipes-scanners =3D> meta-security/recipes-scanners}/clamav/fil=
es/freshclam.conf (100%)
 rename {recipes-scanners =3D> meta-security/recipes-scanners}/clamav/fil=
es/tmpfiles.clamav (100%)
 rename {recipes-scanners =3D> meta-security/recipes-scanners}/clamav/fil=
es/volatiles.03_clamav (100%)
 rename {recipes-scanners =3D> meta-security/recipes-scanners}/rootkits/c=
hkrootkit_0.58b.bb (100%)
 rename {recipes-scanners =3D> meta-security/recipes-scanners}/rootkits/f=
iles/0001-Fix-building-with-gcc-15.patch (100%)
 rename {recipes-scanners =3D> meta-security/recipes-scanners}/rootkits/f=
iles/musl_fix.patch (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/Firejail/f=
irejail/exclude_seccomp_util_compiles.patch (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/Firejail/f=
irejail_0.9.72.bb (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/aircrack-n=
g/aircrack-ng/0001-Remove-build-directory-reference.patch (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/aircrack-n=
g/aircrack-ng_1.7.bb (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/chipsec/ch=
ipsec_1.13.16.bb (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/cryptmount=
/cryptmount_6.2.0.bb (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/ding-libs/=
ding-libs_0.7.0.bb (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/ecryptfs-u=
tils/ecryptfs-utils_111.bb (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/ecryptfs-u=
tils/files/0001-avoid-race-condition.patch (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/ecryptfs-u=
tils/files/define_musl_sword_type.patch (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/ecryptfs-u=
tils/files/ecryptfs-utils-CVE-2016-6224.patch (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/ecryptfs-u=
tils/files/ecryptfs.service (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/fscrypt/fs=
crypt_1.1.0.bb (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/fscryptctl=
/fscryptctl_1.1.0.bb (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/glome/glom=
e_git.bb (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/google-aut=
henticator-libpam/google-authenticator-libpam_1.11.bb (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/isic/files=
/configure_fix.patch (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/isic/files=
/isic-0.07-make.patch (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/isic/files=
/isic-0.07-netinet.patch (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/isic/isic_=
0.07.bb (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/krill/file=
s/0001-Disable-abort-on-panic.patch (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/krill/file=
s/0002-Update-crate-dependencies.patch (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/krill/kril=
l-crates.inc (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/krill/kril=
l_0.16.0.bb (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/libgssglue=
/files/run-ptest (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/libgssglue=
/libgssglue_0.9.bb (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/ncrack/ncr=
ack/0001-fix-ftbfs-with-OpenSSL-4.patch (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/ncrack/ncr=
ack_0.7.bb (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/opendnssec=
/files/0001-Fix-implicit-function-declarations.patch (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/opendnssec=
/files/0001-include-utilities.h.patch (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/opendnssec=
/files/0002-reorder-header-files-and-include-time.h.patch (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/opendnssec=
/files/libdns_conf_fix.patch (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/opendnssec=
/files/libxml2_conf.patch (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/opendnssec=
/opendnssec_2.1.14.bb (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/redhat-sec=
urity/files/find-chroot-py.sh (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/redhat-sec=
urity/files/find-chroot.sh (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/redhat-sec=
urity/files/find-elf4tmp.sh (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/redhat-sec=
urity/files/find-execstack.sh (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/redhat-sec=
urity/files/find-hidden-exec.sh (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/redhat-sec=
urity/files/find-nodrop-groups.sh (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/redhat-sec=
urity/files/find-sh4errors.sh (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/redhat-sec=
urity/files/find-sh4tmp.sh (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/redhat-sec=
urity/files/lib-bin-check.sh (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/redhat-sec=
urity/files/rpm-chksec.sh (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/redhat-sec=
urity/files/rpm-drop-groups.sh (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/redhat-sec=
urity/files/selinux-check-devices.sh (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/redhat-sec=
urity/files/selinux-ls-unconfined.sh (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/redhat-sec=
urity/redhat-security_1.0.bb (100%)
 rename {recipes-security =3D> meta-security/recipes-security}/sshguard/s=
shguard_2.5.1.bb (100%)
 rename {scripts =3D> meta-security/scripts}/ci-cleanup.sh (100%)
 rename {scripts =3D> meta-security/scripts}/upload-error-report (100%)

diff --git a/README.md b/README.md
index c92d3f2..f67df2e 100644
--- a/README.md
+++ b/README.md
@@ -50,7 +50,7 @@ other layers needed. e.g.:
   BBLAYERS ?=3D " \
     /path/to/oe-core/meta \
     /path/to/meta-openembedded/meta-oe \
-    /path/to/layer/meta-security "
+    /path/to/layer/meta-security/meta-security"
=20
 Optional Dynamic layer dependancy
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/kas/kas-security-base.yml b/kas/kas-security-base.yml
index 38043f5..064f3a8 100644
--- a/kas/kas-security-base.yml
+++ b/kas/kas-security-base.yml
@@ -6,7 +6,7 @@ distro: poky
 repos:
   meta-security:
     layers:
-      ../meta-security:
+      meta-security:
       meta-tpm:
       meta-integrity:
       meta-hardening:
diff --git a/classes/aide-base.bbclass b/meta-security/classes/aide-base.=
bbclass
similarity index 100%
rename from classes/aide-base.bbclass
rename to meta-security/classes/aide-base.bbclass
diff --git a/classes/aide-db-init.bbclass b/meta-security/classes/aide-db=
-init.bbclass
similarity index 100%
rename from classes/aide-db-init.bbclass
rename to meta-security/classes/aide-db-init.bbclass
diff --git a/classes/check_security.bbclass b/meta-security/classes/check=
_security.bbclass
similarity index 100%
rename from classes/check_security.bbclass
rename to meta-security/classes/check_security.bbclass
diff --git a/classes/dm-verity-img.bbclass b/meta-security/classes/dm-ver=
ity-img.bbclass
similarity index 100%
rename from classes/dm-verity-img.bbclass
rename to meta-security/classes/dm-verity-img.bbclass
diff --git a/classes/sanity-meta-security.bbclass b/meta-security/classes=
/sanity-meta-security.bbclass
similarity index 100%
rename from classes/sanity-meta-security.bbclass
rename to meta-security/classes/sanity-meta-security.bbclass
diff --git a/conf/distro/include/maintainers-meta-security.inc b/meta-sec=
urity/conf/distro/include/maintainers-meta-security.inc
similarity index 100%
rename from conf/distro/include/maintainers-meta-security.inc
rename to meta-security/conf/distro/include/maintainers-meta-security.inc
diff --git a/conf/layer.conf b/meta-security/conf/layer.conf
similarity index 100%
rename from conf/layer.conf
rename to meta-security/conf/layer.conf
diff --git a/dynamic-layers/meta-perl/recipes-core/packagegroup/packagegr=
oup-core-security.bbappend b/meta-security/dynamic-layers/meta-perl/recip=
es-core/packagegroup/packagegroup-core-security.bbappend
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-core/packagegroup/packagegro=
up-core-security.bbappend
rename to meta-security/dynamic-layers/meta-perl/recipes-core/packagegrou=
p/packagegroup-core-security.bbappend
diff --git a/dynamic-layers/meta-perl/recipes-scanners/checksecurity/chec=
ksecurity_2.0.16.bb b/meta-security/dynamic-layers/meta-perl/recipes-scan=
ners/checksecurity/checksecurity_2.0.16.bb
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-scanners/checksecurity/check=
security_2.0.16.bb
rename to meta-security/dynamic-layers/meta-perl/recipes-scanners/checkse=
curity/checksecurity_2.0.16.bb
diff --git a/dynamic-layers/meta-perl/recipes-scanners/checksecurity/file=
s/check-setuid-use-more-portable-find-args.patch b/meta-security/dynamic-=
layers/meta-perl/recipes-scanners/checksecurity/files/check-setuid-use-mo=
re-portable-find-args.patch
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-scanners/checksecurity/files=
/check-setuid-use-more-portable-find-args.patch
rename to meta-security/dynamic-layers/meta-perl/recipes-scanners/checkse=
curity/files/check-setuid-use-more-portable-find-args.patch
diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/bastille_=
3.2.1.bb b/meta-security/dynamic-layers/meta-perl/recipes-security/bastil=
le/bastille_3.2.1.bb
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-security/bastille/bastille_3=
.2.1.bb
rename to meta-security/dynamic-layers/meta-perl/recipes-security/bastill=
e/bastille_3.2.1.bb
diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/files/API=
.pm b/meta-security/dynamic-layers/meta-perl/recipes-security/bastille/fi=
les/API.pm
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-security/bastille/files/API.=
pm
rename to meta-security/dynamic-layers/meta-perl/recipes-security/bastill=
e/files/API.pm
diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/files/Acc=
ountPermission.pm b/meta-security/dynamic-layers/meta-perl/recipes-securi=
ty/bastille/files/AccountPermission.pm
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-security/bastille/files/Acco=
untPermission.pm
rename to meta-security/dynamic-layers/meta-perl/recipes-security/bastill=
e/files/AccountPermission.pm
diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/files/Fil=
eContent.pm b/meta-security/dynamic-layers/meta-perl/recipes-security/bas=
tille/files/FileContent.pm
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-security/bastille/files/File=
Content.pm
rename to meta-security/dynamic-layers/meta-perl/recipes-security/bastill=
e/files/FileContent.pm
diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/files/HPS=
pecific.pm b/meta-security/dynamic-layers/meta-perl/recipes-security/bast=
ille/files/HPSpecific.pm
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-security/bastille/files/HPSp=
ecific.pm
rename to meta-security/dynamic-layers/meta-perl/recipes-security/bastill=
e/files/HPSpecific.pm
diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/files/Mis=
cellaneous.pm b/meta-security/dynamic-layers/meta-perl/recipes-security/b=
astille/files/Miscellaneous.pm
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-security/bastille/files/Misc=
ellaneous.pm
rename to meta-security/dynamic-layers/meta-perl/recipes-security/bastill=
e/files/Miscellaneous.pm
diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/files/Ser=
viceAdmin.pm b/meta-security/dynamic-layers/meta-perl/recipes-security/ba=
stille/files/ServiceAdmin.pm
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-security/bastille/files/Serv=
iceAdmin.pm
rename to meta-security/dynamic-layers/meta-perl/recipes-security/bastill=
e/files/ServiceAdmin.pm
diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/files/acc=
ept_os_flag_in_backend.patch b/meta-security/dynamic-layers/meta-perl/rec=
ipes-security/bastille/files/accept_os_flag_in_backend.patch
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-security/bastille/files/acce=
pt_os_flag_in_backend.patch
rename to meta-security/dynamic-layers/meta-perl/recipes-security/bastill=
e/files/accept_os_flag_in_backend.patch
diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/files/all=
ow_os_with_assess.patch b/meta-security/dynamic-layers/meta-perl/recipes-=
security/bastille/files/allow_os_with_assess.patch
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-security/bastille/files/allo=
w_os_with_assess.patch
rename to meta-security/dynamic-layers/meta-perl/recipes-security/bastill=
e/files/allow_os_with_assess.patch
diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/files/cal=
l_output_config.patch b/meta-security/dynamic-layers/meta-perl/recipes-se=
curity/bastille/files/call_output_config.patch
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-security/bastille/files/call=
_output_config.patch
rename to meta-security/dynamic-layers/meta-perl/recipes-security/bastill=
e/files/call_output_config.patch
diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/files/con=
fig b/meta-security/dynamic-layers/meta-perl/recipes-security/bastille/fi=
les/config
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-security/bastille/files/conf=
ig
rename to meta-security/dynamic-layers/meta-perl/recipes-security/bastill=
e/files/config
diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/files/do_=
not_apply_config.patch b/meta-security/dynamic-layers/meta-perl/recipes-s=
ecurity/bastille/files/do_not_apply_config.patch
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-security/bastille/files/do_n=
ot_apply_config.patch
rename to meta-security/dynamic-layers/meta-perl/recipes-security/bastill=
e/files/do_not_apply_config.patch
diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/files/edi=
t_usage_message.patch b/meta-security/dynamic-layers/meta-perl/recipes-se=
curity/bastille/files/edit_usage_message.patch
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-security/bastille/files/edit=
_usage_message.patch
rename to meta-security/dynamic-layers/meta-perl/recipes-security/bastill=
e/files/edit_usage_message.patch
diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/files/fin=
d_existing_config.patch b/meta-security/dynamic-layers/meta-perl/recipes-=
security/bastille/files/find_existing_config.patch
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-security/bastille/files/find=
_existing_config.patch
rename to meta-security/dynamic-layers/meta-perl/recipes-security/bastill=
e/files/find_existing_config.patch
diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/files/fix=
_missing_use_directives.patch b/meta-security/dynamic-layers/meta-perl/re=
cipes-security/bastille/files/fix_missing_use_directives.patch
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-security/bastille/files/fix_=
missing_use_directives.patch
rename to meta-security/dynamic-layers/meta-perl/recipes-security/bastill=
e/files/fix_missing_use_directives.patch
diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/files/fix=
_number_of_modules.patch b/meta-security/dynamic-layers/meta-perl/recipes=
-security/bastille/files/fix_number_of_modules.patch
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-security/bastille/files/fix_=
number_of_modules.patch
rename to meta-security/dynamic-layers/meta-perl/recipes-security/bastill=
e/files/fix_number_of_modules.patch
diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/files/fix=
_version_parse.patch b/meta-security/dynamic-layers/meta-perl/recipes-sec=
urity/bastille/files/fix_version_parse.patch
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-security/bastille/files/fix_=
version_parse.patch
rename to meta-security/dynamic-layers/meta-perl/recipes-security/bastill=
e/files/fix_version_parse.patch
diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/files/fix=
ed_defined_warnings.patch b/meta-security/dynamic-layers/meta-perl/recipe=
s-security/bastille/files/fixed_defined_warnings.patch
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-security/bastille/files/fixe=
d_defined_warnings.patch
rename to meta-security/dynamic-layers/meta-perl/recipes-security/bastill=
e/files/fixed_defined_warnings.patch
diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/files/org=
anize_distro_discovery.patch b/meta-security/dynamic-layers/meta-perl/rec=
ipes-security/bastille/files/organize_distro_discovery.patch
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-security/bastille/files/orga=
nize_distro_discovery.patch
rename to meta-security/dynamic-layers/meta-perl/recipes-security/bastill=
e/files/organize_distro_discovery.patch
diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/files/rem=
ove_questions_text_file_references.patch b/meta-security/dynamic-layers/m=
eta-perl/recipes-security/bastille/files/remove_questions_text_file_refer=
ences.patch
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-security/bastille/files/remo=
ve_questions_text_file_references.patch
rename to meta-security/dynamic-layers/meta-perl/recipes-security/bastill=
e/files/remove_questions_text_file_references.patch
diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/files/set=
_required_questions.py b/meta-security/dynamic-layers/meta-perl/recipes-s=
ecurity/bastille/files/set_required_questions.py
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-security/bastille/files/set_=
required_questions.py
rename to meta-security/dynamic-layers/meta-perl/recipes-security/bastill=
e/files/set_required_questions.py
diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/files/sim=
plify_B_place.patch b/meta-security/dynamic-layers/meta-perl/recipes-secu=
rity/bastille/files/simplify_B_place.patch
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-security/bastille/files/simp=
lify_B_place.patch
rename to meta-security/dynamic-layers/meta-perl/recipes-security/bastill=
e/files/simplify_B_place.patch
diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/files/upg=
rade_options_processing.patch b/meta-security/dynamic-layers/meta-perl/re=
cipes-security/bastille/files/upgrade_options_processing.patch
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-security/bastille/files/upgr=
ade_options_processing.patch
rename to meta-security/dynamic-layers/meta-perl/recipes-security/bastill=
e/files/upgrade_options_processing.patch
diff --git a/dynamic-layers/meta-perl/recipes-security/nikto/files/locati=
on.patch b/meta-security/dynamic-layers/meta-perl/recipes-security/nikto/=
files/location.patch
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-security/nikto/files/locatio=
n.patch
rename to meta-security/dynamic-layers/meta-perl/recipes-security/nikto/f=
iles/location.patch
diff --git a/dynamic-layers/meta-perl/recipes-security/nikto/nikto_2.1.6.=
bb b/meta-security/dynamic-layers/meta-perl/recipes-security/nikto/nikto_=
2.1.6.bb
similarity index 100%
rename from dynamic-layers/meta-perl/recipes-security/nikto/nikto_2.1.6.b=
b
rename to meta-security/dynamic-layers/meta-perl/recipes-security/nikto/n=
ikto_2.1.6.bb
diff --git a/dynamic-layers/meta-python/recipes-core/packagegroup/package=
group-core-security.bbappend b/meta-security/dynamic-layers/meta-python/r=
ecipes-core/packagegroup/packagegroup-core-security.bbappend
similarity index 100%
rename from dynamic-layers/meta-python/recipes-core/packagegroup/packageg=
roup-core-security.bbappend
rename to meta-security/dynamic-layers/meta-python/recipes-core/packagegr=
oup/packagegroup-core-security.bbappend
diff --git a/dynamic-layers/meta-python/recipes-devtools/python/python3-f=
lask-script_2.0.6.bb b/meta-security/dynamic-layers/meta-python/recipes-d=
evtools/python/python3-flask-script_2.0.6.bb
similarity index 100%
rename from dynamic-layers/meta-python/recipes-devtools/python/python3-fl=
ask-script_2.0.6.bb
rename to meta-security/dynamic-layers/meta-python/recipes-devtools/pytho=
n/python3-flask-script_2.0.6.bb
diff --git a/dynamic-layers/meta-python/recipes-devtools/python/python3-j=
son2html_1.3.0.bb b/meta-security/dynamic-layers/meta-python/recipes-devt=
ools/python/python3-json2html_1.3.0.bb
similarity index 100%
rename from dynamic-layers/meta-python/recipes-devtools/python/python3-js=
on2html_1.3.0.bb
rename to meta-security/dynamic-layers/meta-python/recipes-devtools/pytho=
n/python3-json2html_1.3.0.bb
diff --git a/dynamic-layers/meta-python/recipes-devtools/python/python3-p=
yinotify/0001-Make-asyncore-support-optional-for-Python-3.patch b/meta-se=
curity/dynamic-layers/meta-python/recipes-devtools/python/python3-pyinoti=
fy/0001-Make-asyncore-support-optional-for-Python-3.patch
similarity index 100%
rename from dynamic-layers/meta-python/recipes-devtools/python/python3-py=
inotify/0001-Make-asyncore-support-optional-for-Python-3.patch
rename to meta-security/dynamic-layers/meta-python/recipes-devtools/pytho=
n/python3-pyinotify/0001-Make-asyncore-support-optional-for-Python-3.patc=
h
diff --git a/dynamic-layers/meta-python/recipes-devtools/python/python3-p=
yinotify_0.9.6.bb b/meta-security/dynamic-layers/meta-python/recipes-devt=
ools/python/python3-pyinotify_0.9.6.bb
similarity index 100%
rename from dynamic-layers/meta-python/recipes-devtools/python/python3-py=
inotify_0.9.6.bb
rename to meta-security/dynamic-layers/meta-python/recipes-devtools/pytho=
n/python3-pyinotify_0.9.6.bb
diff --git a/dynamic-layers/meta-python/recipes-devtools/python/python3-s=
egno_1.5.2.bb b/meta-security/dynamic-layers/meta-python/recipes-devtools=
/python/python3-segno_1.5.2.bb
similarity index 100%
rename from dynamic-layers/meta-python/recipes-devtools/python/python3-se=
gno_1.5.2.bb
rename to meta-security/dynamic-layers/meta-python/recipes-devtools/pytho=
n/python3-segno_1.5.2.bb
diff --git a/dynamic-layers/meta-python/recipes-devtools/python/python3-x=
mldiff_2.7.0.bb b/meta-security/dynamic-layers/meta-python/recipes-devtoo=
ls/python/python3-xmldiff_2.7.0.bb
similarity index 100%
rename from dynamic-layers/meta-python/recipes-devtools/python/python3-xm=
ldiff_2.7.0.bb
rename to meta-security/dynamic-layers/meta-python/recipes-devtools/pytho=
n/python3-xmldiff_2.7.0.bb
diff --git a/dynamic-layers/meta-python/recipes-devtools/python/python3-y=
amlpath_3.8.2.bb b/meta-security/dynamic-layers/meta-python/recipes-devto=
ols/python/python3-yamlpath_3.8.2.bb
similarity index 100%
rename from dynamic-layers/meta-python/recipes-devtools/python/python3-ya=
mlpath_3.8.2.bb
rename to meta-security/dynamic-layers/meta-python/recipes-devtools/pytho=
n/python3-yamlpath_3.8.2.bb
diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0=
001-fail2ban-use-putao.unittest.TestRunner-for-ptest-out.patch b/meta-sec=
urity/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-fai=
l2ban-use-putao.unittest.TestRunner-for-ptest-out.patch
similarity index 100%
rename from dynamic-layers/meta-python/recipes-security/fail2ban/files/00=
01-fail2ban-use-putao.unittest.TestRunner-for-ptest-out.patch
rename to meta-security/dynamic-layers/meta-python/recipes-security/fail2=
ban/files/0001-fail2ban-use-putao.unittest.TestRunner-for-ptest-out.patch
diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/files/i=
nitd b/meta-security/dynamic-layers/meta-python/recipes-security/fail2ban=
/files/initd
similarity index 100%
rename from dynamic-layers/meta-python/recipes-security/fail2ban/files/in=
itd
rename to meta-security/dynamic-layers/meta-python/recipes-security/fail2=
ban/files/initd
diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/files/r=
un-ptest b/meta-security/dynamic-layers/meta-python/recipes-security/fail=
2ban/files/run-ptest
similarity index 100%
rename from dynamic-layers/meta-python/recipes-security/fail2ban/files/ru=
n-ptest
rename to meta-security/dynamic-layers/meta-python/recipes-security/fail2=
ban/files/run-ptest
diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/python3=
-fail2ban_git.bb b/meta-security/dynamic-layers/meta-python/recipes-secur=
ity/fail2ban/python3-fail2ban_git.bb
similarity index 100%
rename from dynamic-layers/meta-python/recipes-security/fail2ban/python3-=
fail2ban_git.bb
rename to meta-security/dynamic-layers/meta-python/recipes-security/fail2=
ban/python3-fail2ban_git.bb
diff --git a/dynamic-layers/meta-python/recipes-security/mfa/python3-priv=
acyidea_3.9.1.bb b/meta-security/dynamic-layers/meta-python/recipes-secur=
ity/mfa/python3-privacyidea_3.9.1.bb
similarity index 100%
rename from dynamic-layers/meta-python/recipes-security/mfa/python3-priva=
cyidea_3.9.1.bb
rename to meta-security/dynamic-layers/meta-python/recipes-security/mfa/p=
ython3-privacyidea_3.9.1.bb
diff --git a/dynamic-layers/meta-python/recipes-security/python/python3-o=
auth2client_4.1.3.bb b/meta-security/dynamic-layers/meta-python/recipes-s=
ecurity/python/python3-oauth2client_4.1.3.bb
similarity index 100%
rename from dynamic-layers/meta-python/recipes-security/python/python3-oa=
uth2client_4.1.3.bb
rename to meta-security/dynamic-layers/meta-python/recipes-security/pytho=
n/python3-oauth2client_4.1.3.bb
diff --git a/dynamic-layers/networking-layer/recipes-core/packagegroup/pa=
ckagegroup-core-security.bbappend b/meta-security/dynamic-layers/networki=
ng-layer/recipes-core/packagegroup/packagegroup-core-security.bbappend
similarity index 100%
rename from dynamic-layers/networking-layer/recipes-core/packagegroup/pac=
kagegroup-core-security.bbappend
rename to meta-security/dynamic-layers/networking-layer/recipes-core/pack=
agegroup/packagegroup-core-security.bbappend
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/=
drop_ntpdate_chk.patch b/meta-security/dynamic-layers/networking-layer/re=
cipes-security/sssd/files/drop_ntpdate_chk.patch
similarity index 100%
rename from dynamic-layers/networking-layer/recipes-security/sssd/files/d=
rop_ntpdate_chk.patch
rename to meta-security/dynamic-layers/networking-layer/recipes-security/=
sssd/files/drop_ntpdate_chk.patch
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/=
fix-ldblibdir.patch b/meta-security/dynamic-layers/networking-layer/recip=
es-security/sssd/files/fix-ldblibdir.patch
similarity index 100%
rename from dynamic-layers/networking-layer/recipes-security/sssd/files/f=
ix-ldblibdir.patch
rename to meta-security/dynamic-layers/networking-layer/recipes-security/=
sssd/files/fix-ldblibdir.patch
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/=
fix_gid.patch b/meta-security/dynamic-layers/networking-layer/recipes-sec=
urity/sssd/files/fix_gid.patch
similarity index 100%
rename from dynamic-layers/networking-layer/recipes-security/sssd/files/f=
ix_gid.patch
rename to meta-security/dynamic-layers/networking-layer/recipes-security/=
sssd/files/fix_gid.patch
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/=
musl_fixup.patch b/meta-security/dynamic-layers/networking-layer/recipes-=
security/sssd/files/musl_fixup.patch
similarity index 100%
rename from dynamic-layers/networking-layer/recipes-security/sssd/files/m=
usl_fixup.patch
rename to meta-security/dynamic-layers/networking-layer/recipes-security/=
sssd/files/musl_fixup.patch
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/=
no_gen.patch b/meta-security/dynamic-layers/networking-layer/recipes-secu=
rity/sssd/files/no_gen.patch
similarity index 100%
rename from dynamic-layers/networking-layer/recipes-security/sssd/files/n=
o_gen.patch
rename to meta-security/dynamic-layers/networking-layer/recipes-security/=
sssd/files/no_gen.patch
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/=
sssd.conf b/meta-security/dynamic-layers/networking-layer/recipes-securit=
y/sssd/files/sssd.conf
similarity index 100%
rename from dynamic-layers/networking-layer/recipes-security/sssd/files/s=
ssd.conf
rename to meta-security/dynamic-layers/networking-layer/recipes-security/=
sssd/files/sssd.conf
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2=
.13.1.bb b/meta-security/dynamic-layers/networking-layer/recipes-security=
/sssd/sssd_2.13.1.bb
similarity index 100%
rename from dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.=
13.1.bb
rename to meta-security/dynamic-layers/networking-layer/recipes-security/=
sssd/sssd_2.13.1.bb
diff --git a/files/wic/beaglebone-yocto-verity.wks.in b/meta-security/fil=
es/wic/beaglebone-yocto-verity.wks.in
similarity index 100%
rename from files/wic/beaglebone-yocto-verity.wks.in
rename to meta-security/files/wic/beaglebone-yocto-verity.wks.in
diff --git a/files/wic/systemd-bootdisk-dmverity-hash.wks.in b/meta-secur=
ity/files/wic/systemd-bootdisk-dmverity-hash.wks.in
similarity index 100%
rename from files/wic/systemd-bootdisk-dmverity-hash.wks.in
rename to meta-security/files/wic/systemd-bootdisk-dmverity-hash.wks.in
diff --git a/files/wic/systemd-bootdisk-dmverity.wks.in b/meta-security/f=
iles/wic/systemd-bootdisk-dmverity.wks.in
similarity index 100%
rename from files/wic/systemd-bootdisk-dmverity.wks.in
rename to meta-security/files/wic/systemd-bootdisk-dmverity.wks.in
diff --git a/lib/oeqa/runtime/cases/aide.py b/meta-security/lib/oeqa/runt=
ime/cases/aide.py
similarity index 100%
rename from lib/oeqa/runtime/cases/aide.py
rename to meta-security/lib/oeqa/runtime/cases/aide.py
diff --git a/lib/oeqa/runtime/cases/apparmor.py b/meta-security/lib/oeqa/=
runtime/cases/apparmor.py
similarity index 100%
rename from lib/oeqa/runtime/cases/apparmor.py
rename to meta-security/lib/oeqa/runtime/cases/apparmor.py
diff --git a/lib/oeqa/runtime/cases/checksec.py b/meta-security/lib/oeqa/=
runtime/cases/checksec.py
similarity index 100%
rename from lib/oeqa/runtime/cases/checksec.py
rename to meta-security/lib/oeqa/runtime/cases/checksec.py
diff --git a/lib/oeqa/runtime/cases/clamav.py b/meta-security/lib/oeqa/ru=
ntime/cases/clamav.py
similarity index 100%
rename from lib/oeqa/runtime/cases/clamav.py
rename to meta-security/lib/oeqa/runtime/cases/clamav.py
diff --git a/lib/oeqa/runtime/cases/firejail.py b/meta-security/lib/oeqa/=
runtime/cases/firejail.py
similarity index 100%
rename from lib/oeqa/runtime/cases/firejail.py
rename to meta-security/lib/oeqa/runtime/cases/firejail.py
diff --git a/lib/oeqa/runtime/cases/openscap.py b/meta-security/lib/oeqa/=
runtime/cases/openscap.py
similarity index 100%
rename from lib/oeqa/runtime/cases/openscap.py
rename to meta-security/lib/oeqa/runtime/cases/openscap.py
diff --git a/lib/oeqa/runtime/cases/samhain.py b/meta-security/lib/oeqa/r=
untime/cases/samhain.py
similarity index 100%
rename from lib/oeqa/runtime/cases/samhain.py
rename to meta-security/lib/oeqa/runtime/cases/samhain.py
diff --git a/lib/oeqa/runtime/cases/smack.py b/meta-security/lib/oeqa/run=
time/cases/smack.py
similarity index 100%
rename from lib/oeqa/runtime/cases/smack.py
rename to meta-security/lib/oeqa/runtime/cases/smack.py
diff --git a/lib/oeqa/runtime/cases/sssd.py b/meta-security/lib/oeqa/runt=
ime/cases/sssd.py
similarity index 100%
rename from lib/oeqa/runtime/cases/sssd.py
rename to meta-security/lib/oeqa/runtime/cases/sssd.py
diff --git a/lib/oeqa/runtime/cases/suricata.py b/meta-security/lib/oeqa/=
runtime/cases/suricata.py
similarity index 100%
rename from lib/oeqa/runtime/cases/suricata.py
rename to meta-security/lib/oeqa/runtime/cases/suricata.py
diff --git a/lib/oeqa/selftest/cases/cvechecker.py b/meta-security/lib/oe=
qa/selftest/cases/cvechecker.py
similarity index 100%
rename from lib/oeqa/selftest/cases/cvechecker.py
rename to meta-security/lib/oeqa/selftest/cases/cvechecker.py
diff --git a/recipes-compliance/lynis/lynis_3.1.7.bb b/meta-security/reci=
pes-compliance/lynis/lynis_3.1.7.bb
similarity index 100%
rename from recipes-compliance/lynis/lynis_3.1.7.bb
rename to meta-security/recipes-compliance/lynis/lynis_3.1.7.bb
diff --git a/recipes-compliance/openscap/files/0001-CMakeLists.txt-fix-in=
stallation-directory-for-system.patch b/meta-security/recipes-compliance/=
openscap/files/0001-CMakeLists.txt-fix-installation-directory-for-system.=
patch
similarity index 100%
rename from recipes-compliance/openscap/files/0001-CMakeLists.txt-fix-ins=
tallation-directory-for-system.patch
rename to meta-security/recipes-compliance/openscap/files/0001-CMakeLists=
.txt-fix-installation-directory-for-system.patch
diff --git a/recipes-compliance/openscap/files/0002-Replace-removed-Pytho=
n-2-C-API-macros-for-SWIG-4.5.0.patch b/meta-security/recipes-compliance/=
openscap/files/0002-Replace-removed-Python-2-C-API-macros-for-SWIG-4.5.0.=
patch
similarity index 100%
rename from recipes-compliance/openscap/files/0002-Replace-removed-Python=
-2-C-API-macros-for-SWIG-4.5.0.patch
rename to meta-security/recipes-compliance/openscap/files/0002-Replace-re=
moved-Python-2-C-API-macros-for-SWIG-4.5.0.patch
diff --git a/recipes-compliance/openscap/openscap_1.4.4.bb b/meta-securit=
y/recipes-compliance/openscap/openscap_1.4.4.bb
similarity index 100%
rename from recipes-compliance/openscap/openscap_1.4.4.bb
rename to meta-security/recipes-compliance/openscap/openscap_1.4.4.bb
diff --git a/recipes-compliance/scap-security-guide/files/run_eval.sh b/m=
eta-security/recipes-compliance/scap-security-guide/files/run_eval.sh
similarity index 100%
rename from recipes-compliance/scap-security-guide/files/run_eval.sh
rename to meta-security/recipes-compliance/scap-security-guide/files/run_=
eval.sh
diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0=
.1.81.bb b/meta-security/recipes-compliance/scap-security-guide/scap-secu=
rity-guide_0.1.81.bb
similarity index 100%
rename from recipes-compliance/scap-security-guide/scap-security-guide_0.=
1.81.bb
rename to meta-security/recipes-compliance/scap-security-guide/scap-secur=
ity-guide_0.1.81.bb
diff --git a/recipes-core/images/dm-verity-image-initramfs.bb b/meta-secu=
rity/recipes-core/images/dm-verity-image-initramfs.bb
similarity index 100%
rename from recipes-core/images/dm-verity-image-initramfs.bb
rename to meta-security/recipes-core/images/dm-verity-image-initramfs.bb
diff --git a/recipes-core/images/security-build-image.bb b/meta-security/=
recipes-core/images/security-build-image.bb
similarity index 100%
rename from recipes-core/images/security-build-image.bb
rename to meta-security/recipes-core/images/security-build-image.bb
diff --git a/recipes-core/images/security-client-image.bb b/meta-security=
/recipes-core/images/security-client-image.bb
similarity index 100%
rename from recipes-core/images/security-client-image.bb
rename to meta-security/recipes-core/images/security-client-image.bb
diff --git a/recipes-core/images/security-server-image.bb b/meta-security=
/recipes-core/images/security-server-image.bb
similarity index 100%
rename from recipes-core/images/security-server-image.bb
rename to meta-security/recipes-core/images/security-server-image.bb
diff --git a/recipes-core/images/security-test-image.bb b/meta-security/r=
ecipes-core/images/security-test-image.bb
similarity index 100%
rename from recipes-core/images/security-test-image.bb
rename to meta-security/recipes-core/images/security-test-image.bb
diff --git a/recipes-core/initrdscripts/initramfs-framework-dm/dmverity b=
/meta-security/recipes-core/initrdscripts/initramfs-framework-dm/dmverity
similarity index 100%
rename from recipes-core/initrdscripts/initramfs-framework-dm/dmverity
rename to meta-security/recipes-core/initrdscripts/initramfs-framework-dm=
/dmverity
diff --git a/recipes-core/initrdscripts/initramfs-framework.inc b/meta-se=
curity/recipes-core/initrdscripts/initramfs-framework.inc
similarity index 100%
rename from recipes-core/initrdscripts/initramfs-framework.inc
rename to meta-security/recipes-core/initrdscripts/initramfs-framework.in=
c
diff --git a/recipes-core/initrdscripts/initramfs-framework_1.0.bbappend =
b/meta-security/recipes-core/initrdscripts/initramfs-framework_1.0.bbappe=
nd
similarity index 100%
rename from recipes-core/initrdscripts/initramfs-framework_1.0.bbappend
rename to meta-security/recipes-core/initrdscripts/initramfs-framework_1.=
0.bbappend
diff --git a/recipes-core/packagegroup/packagegroup-core-security.bb b/me=
ta-security/recipes-core/packagegroup/packagegroup-core-security.bb
similarity index 100%
rename from recipes-core/packagegroup/packagegroup-core-security.bb
rename to meta-security/recipes-core/packagegroup/packagegroup-core-secur=
ity.bb
diff --git a/recipes-ids/aide/aide/0001-Fixes-build-issues.patch b/meta-s=
ecurity/recipes-ids/aide/aide/0001-Fixes-build-issues.patch
similarity index 100%
rename from recipes-ids/aide/aide/0001-Fixes-build-issues.patch
rename to meta-security/recipes-ids/aide/aide/0001-Fixes-build-issues.pat=
ch
diff --git a/recipes-ids/aide/aide/aide.conf b/meta-security/recipes-ids/=
aide/aide/aide.conf
similarity index 100%
rename from recipes-ids/aide/aide/aide.conf
rename to meta-security/recipes-ids/aide/aide/aide.conf
diff --git a/recipes-ids/aide/aide_0.19.4.bb b/meta-security/recipes-ids/=
aide/aide_0.19.4.bb
similarity index 100%
rename from recipes-ids/aide/aide_0.19.4.bb
rename to meta-security/recipes-ids/aide/aide_0.19.4.bb
diff --git a/recipes-ids/crowdsec/crowdsec-go-mods.inc b/meta-security/re=
cipes-ids/crowdsec/crowdsec-go-mods.inc
similarity index 100%
rename from recipes-ids/crowdsec/crowdsec-go-mods.inc
rename to meta-security/recipes-ids/crowdsec/crowdsec-go-mods.inc
diff --git a/recipes-ids/crowdsec/crowdsec-licenses.inc b/meta-security/r=
ecipes-ids/crowdsec/crowdsec-licenses.inc
similarity index 100%
rename from recipes-ids/crowdsec/crowdsec-licenses.inc
rename to meta-security/recipes-ids/crowdsec/crowdsec-licenses.inc
diff --git a/recipes-ids/crowdsec/crowdsec_1.8.1.bb b/meta-security/recip=
es-ids/crowdsec/crowdsec_1.8.1.bb
similarity index 100%
rename from recipes-ids/crowdsec/crowdsec_1.8.1.bb
rename to meta-security/recipes-ids/crowdsec/crowdsec_1.8.1.bb
diff --git a/recipes-ids/ossec/files/0001-Makefile-drop-running-scrips-in=
stall.patch b/meta-security/recipes-ids/ossec/files/0001-Makefile-drop-ru=
nning-scrips-install.patch
similarity index 100%
rename from recipes-ids/ossec/files/0001-Makefile-drop-running-scrips-ins=
tall.patch
rename to meta-security/recipes-ids/ossec/files/0001-Makefile-drop-runnin=
g-scrips-install.patch
diff --git a/recipes-ids/ossec/files/0002-Makefile-don-t-set-uid-gid.patc=
h b/meta-security/recipes-ids/ossec/files/0002-Makefile-don-t-set-uid-gid=
.patch
similarity index 100%
rename from recipes-ids/ossec/files/0002-Makefile-don-t-set-uid-gid.patch
rename to meta-security/recipes-ids/ossec/files/0002-Makefile-don-t-set-u=
id-gid.patch
diff --git a/recipes-ids/ossec/files/0003-Add-OpenSSL-4.0-support.patch b=
/meta-security/recipes-ids/ossec/files/0003-Add-OpenSSL-4.0-support.patch
similarity index 100%
rename from recipes-ids/ossec/files/0003-Add-OpenSSL-4.0-support.patch
rename to meta-security/recipes-ids/ossec/files/0003-Add-OpenSSL-4.0-supp=
ort.patch
diff --git a/recipes-ids/ossec/ossec-hids_4.3.0.bb b/meta-security/recipe=
s-ids/ossec/ossec-hids_4.3.0.bb
similarity index 100%
rename from recipes-ids/ossec/ossec-hids_4.3.0.bb
rename to meta-security/recipes-ids/ossec/ossec-hids_4.3.0.bb
diff --git a/recipes-ids/samhain/files/0001-Format-test-output-to-match-A=
utomake-standards.patch b/meta-security/recipes-ids/samhain/files/0001-Fo=
rmat-test-output-to-match-Automake-standards.patch
similarity index 100%
rename from recipes-ids/samhain/files/0001-Format-test-output-to-match-Au=
tomake-standards.patch
rename to meta-security/recipes-ids/samhain/files/0001-Format-test-output=
-to-match-Automake-standards.patch
diff --git a/recipes-ids/samhain/files/0001-Hash-fix-for-MIPS64-and-AARCH=
64.patch b/meta-security/recipes-ids/samhain/files/0001-Hash-fix-for-MIPS=
64-and-AARCH64.patch
similarity index 100%
rename from recipes-ids/samhain/files/0001-Hash-fix-for-MIPS64-and-AARCH6=
4.patch
rename to meta-security/recipes-ids/samhain/files/0001-Hash-fix-for-MIPS6=
4-and-AARCH64.patch
diff --git a/recipes-ids/samhain/files/0002-Make-samhainrc-OE-friendly.pa=
tch b/meta-security/recipes-ids/samhain/files/0002-Make-samhainrc-OE-frie=
ndly.patch
similarity index 100%
rename from recipes-ids/samhain/files/0002-Make-samhainrc-OE-friendly.pat=
ch
rename to meta-security/recipes-ids/samhain/files/0002-Make-samhainrc-OE-=
friendly.patch
diff --git a/recipes-ids/samhain/files/0003-fix-real-path-for-some-files-=
dirs.patch b/meta-security/recipes-ids/samhain/files/0003-fix-real-path-f=
or-some-files-dirs.patch
similarity index 100%
rename from recipes-ids/samhain/files/0003-fix-real-path-for-some-files-d=
irs.patch
rename to meta-security/recipes-ids/samhain/files/0003-fix-real-path-for-=
some-files-dirs.patch
diff --git a/recipes-ids/samhain/files/0004-Set-the-PID-Lock-path-for-sam=
hain.pid.patch b/meta-security/recipes-ids/samhain/files/0004-Set-the-PID=
-Lock-path-for-samhain.pid.patch
similarity index 100%
rename from recipes-ids/samhain/files/0004-Set-the-PID-Lock-path-for-samh=
ain.pid.patch
rename to meta-security/recipes-ids/samhain/files/0004-Set-the-PID-Lock-p=
ath-for-samhain.pid.patch
diff --git a/recipes-ids/samhain/files/0005-Fix-sha256-for-big-endian-mac=
hines.patch b/meta-security/recipes-ids/samhain/files/0005-Fix-sha256-for=
-big-endian-machines.patch
similarity index 100%
rename from recipes-ids/samhain/files/0005-Fix-sha256-for-big-endian-mach=
ines.patch
rename to meta-security/recipes-ids/samhain/files/0005-Fix-sha256-for-big=
-endian-machines.patch
diff --git a/recipes-ids/samhain/files/0006-configure-add-option-for-ps.p=
atch b/meta-security/recipes-ids/samhain/files/0006-configure-add-option-=
for-ps.patch
similarity index 100%
rename from recipes-ids/samhain/files/0006-configure-add-option-for-ps.pa=
tch
rename to meta-security/recipes-ids/samhain/files/0006-configure-add-opti=
on-for-ps.patch
diff --git a/recipes-ids/samhain/files/0007-configure.ac-avoid-searching-=
host-for-postgresql.patch b/meta-security/recipes-ids/samhain/files/0007-=
configure.ac-avoid-searching-host-for-postgresql.patch
similarity index 100%
rename from recipes-ids/samhain/files/0007-configure.ac-avoid-searching-h=
ost-for-postgresql.patch
rename to meta-security/recipes-ids/samhain/files/0007-configure.ac-avoid=
-searching-host-for-postgresql.patch
diff --git a/recipes-ids/samhain/files/0008-Add-LDFLAGS-variable-for-comp=
iling-samhain_setpwd.patch b/meta-security/recipes-ids/samhain/files/0008=
-Add-LDFLAGS-variable-for-compiling-samhain_setpwd.patch
similarity index 100%
rename from recipes-ids/samhain/files/0008-Add-LDFLAGS-variable-for-compi=
ling-samhain_setpwd.patch
rename to meta-security/recipes-ids/samhain/files/0008-Add-LDFLAGS-variab=
le-for-compiling-samhain_setpwd.patch
diff --git a/recipes-ids/samhain/files/0009-fix-build-with-new-version-at=
tr.patch b/meta-security/recipes-ids/samhain/files/0009-fix-build-with-ne=
w-version-attr.patch
similarity index 100%
rename from recipes-ids/samhain/files/0009-fix-build-with-new-version-att=
r.patch
rename to meta-security/recipes-ids/samhain/files/0009-fix-build-with-new=
-version-attr.patch
diff --git a/recipes-ids/samhain/files/0010-Fix-initializer-element-is-no=
t-constant.patch b/meta-security/recipes-ids/samhain/files/0010-Fix-initi=
alizer-element-is-not-constant.patch
similarity index 100%
rename from recipes-ids/samhain/files/0010-Fix-initializer-element-is-not=
-constant.patch
rename to meta-security/recipes-ids/samhain/files/0010-Fix-initializer-el=
ement-is-not-constant.patch
diff --git a/recipes-ids/samhain/files/0011-not-run-test-on-host-since-we=
-are-doing-cross-compil.patch b/meta-security/recipes-ids/samhain/files/0=
011-not-run-test-on-host-since-we-are-doing-cross-compil.patch
similarity index 100%
rename from recipes-ids/samhain/files/0011-not-run-test-on-host-since-we-=
are-doing-cross-compil.patch
rename to meta-security/recipes-ids/samhain/files/0011-not-run-test-on-ho=
st-since-we-are-doing-cross-compil.patch
diff --git a/recipes-ids/samhain/files/0012-Don-t-expose-configure-args.p=
atch b/meta-security/recipes-ids/samhain/files/0012-Don-t-expose-configur=
e-args.patch
similarity index 100%
rename from recipes-ids/samhain/files/0012-Don-t-expose-configure-args.pa=
tch
rename to meta-security/recipes-ids/samhain/files/0012-Don-t-expose-confi=
gure-args.patch
diff --git a/recipes-ids/samhain/files/0013-yulerc-set-SetLockfilePath-to=
-run-yule.pid.patch b/meta-security/recipes-ids/samhain/files/0013-yulerc=
-set-SetLockfilePath-to-run-yule.pid.patch
similarity index 100%
rename from recipes-ids/samhain/files/0013-yulerc-set-SetLockfilePath-to-=
run-yule.pid.patch
rename to meta-security/recipes-ids/samhain/files/0013-yulerc-set-SetLock=
filePath-to-run-yule.pid.patch
diff --git a/recipes-ids/samhain/files/run-ptest b/meta-security/recipes-=
ids/samhain/files/run-ptest
similarity index 100%
rename from recipes-ids/samhain/files/run-ptest
rename to meta-security/recipes-ids/samhain/files/run-ptest
diff --git a/recipes-ids/samhain/files/samhain-client.default b/meta-secu=
rity/recipes-ids/samhain/files/samhain-client.default
similarity index 100%
rename from recipes-ids/samhain/files/samhain-client.default
rename to meta-security/recipes-ids/samhain/files/samhain-client.default
diff --git a/recipes-ids/samhain/files/samhain-client.init b/meta-securit=
y/recipes-ids/samhain/files/samhain-client.init
similarity index 100%
rename from recipes-ids/samhain/files/samhain-client.init
rename to meta-security/recipes-ids/samhain/files/samhain-client.init
diff --git a/recipes-ids/samhain/files/samhain-server-volatiles b/meta-se=
curity/recipes-ids/samhain/files/samhain-server-volatiles
similarity index 100%
rename from recipes-ids/samhain/files/samhain-server-volatiles
rename to meta-security/recipes-ids/samhain/files/samhain-server-volatile=
s
diff --git a/recipes-ids/samhain/files/samhain-server-volatiles.conf b/me=
ta-security/recipes-ids/samhain/files/samhain-server-volatiles.conf
similarity index 100%
rename from recipes-ids/samhain/files/samhain-server-volatiles.conf
rename to meta-security/recipes-ids/samhain/files/samhain-server-volatile=
s.conf
diff --git a/recipes-ids/samhain/files/samhain-server.default b/meta-secu=
rity/recipes-ids/samhain/files/samhain-server.default
similarity index 100%
rename from recipes-ids/samhain/files/samhain-server.default
rename to meta-security/recipes-ids/samhain/files/samhain-server.default
diff --git a/recipes-ids/samhain/files/samhain-server.init b/meta-securit=
y/recipes-ids/samhain/files/samhain-server.init
similarity index 100%
rename from recipes-ids/samhain/files/samhain-server.init
rename to meta-security/recipes-ids/samhain/files/samhain-server.init
diff --git a/recipes-ids/samhain/files/samhain-standalone.default b/meta-=
security/recipes-ids/samhain/files/samhain-standalone.default
similarity index 100%
rename from recipes-ids/samhain/files/samhain-standalone.default
rename to meta-security/recipes-ids/samhain/files/samhain-standalone.defa=
ult
diff --git a/recipes-ids/samhain/files/samhain-standalone.init b/meta-sec=
urity/recipes-ids/samhain/files/samhain-standalone.init
similarity index 100%
rename from recipes-ids/samhain/files/samhain-standalone.init
rename to meta-security/recipes-ids/samhain/files/samhain-standalone.init
diff --git a/recipes-ids/samhain/files/samhain.service b/meta-security/re=
cipes-ids/samhain/files/samhain.service
similarity index 100%
rename from recipes-ids/samhain/files/samhain.service
rename to meta-security/recipes-ids/samhain/files/samhain.service
diff --git a/recipes-ids/samhain/samhain-client.bb b/meta-security/recipe=
s-ids/samhain/samhain-client.bb
similarity index 100%
rename from recipes-ids/samhain/samhain-client.bb
rename to meta-security/recipes-ids/samhain/samhain-client.bb
diff --git a/recipes-ids/samhain/samhain-server.bb b/meta-security/recipe=
s-ids/samhain/samhain-server.bb
similarity index 100%
rename from recipes-ids/samhain/samhain-server.bb
rename to meta-security/recipes-ids/samhain/samhain-server.bb
diff --git a/recipes-ids/samhain/samhain-standalone.bb b/meta-security/re=
cipes-ids/samhain/samhain-standalone.bb
similarity index 100%
rename from recipes-ids/samhain/samhain-standalone.bb
rename to meta-security/recipes-ids/samhain/samhain-standalone.bb
diff --git a/recipes-ids/samhain/samhain.inc b/meta-security/recipes-ids/=
samhain/samhain.inc
similarity index 100%
rename from recipes-ids/samhain/samhain.inc
rename to meta-security/recipes-ids/samhain/samhain.inc
diff --git a/recipes-ids/suricata/files/0001-Skip-pkg-Makefile-from-using=
-its-own-rust-steps.patch b/meta-security/recipes-ids/suricata/files/0001=
-Skip-pkg-Makefile-from-using-its-own-rust-steps.patch
similarity index 100%
rename from recipes-ids/suricata/files/0001-Skip-pkg-Makefile-from-using-=
its-own-rust-steps.patch
rename to meta-security/recipes-ids/suricata/files/0001-Skip-pkg-Makefile=
-from-using-its-own-rust-steps.patch
diff --git a/recipes-ids/suricata/files/run-ptest b/meta-security/recipes=
-ids/suricata/files/run-ptest
similarity index 100%
rename from recipes-ids/suricata/files/run-ptest
rename to meta-security/recipes-ids/suricata/files/run-ptest
diff --git a/recipes-ids/suricata/files/suricata.service b/meta-security/=
recipes-ids/suricata/files/suricata.service
similarity index 100%
rename from recipes-ids/suricata/files/suricata.service
rename to meta-security/recipes-ids/suricata/files/suricata.service
diff --git a/recipes-ids/suricata/files/suricata.yaml b/meta-security/rec=
ipes-ids/suricata/files/suricata.yaml
similarity index 100%
rename from recipes-ids/suricata/files/suricata.yaml
rename to meta-security/recipes-ids/suricata/files/suricata.yaml
diff --git a/recipes-ids/suricata/files/tmpfiles.suricata b/meta-security=
/recipes-ids/suricata/files/tmpfiles.suricata
similarity index 100%
rename from recipes-ids/suricata/files/tmpfiles.suricata
rename to meta-security/recipes-ids/suricata/files/tmpfiles.suricata
diff --git a/recipes-ids/suricata/files/volatiles.03_suricata b/meta-secu=
rity/recipes-ids/suricata/files/volatiles.03_suricata
similarity index 100%
rename from recipes-ids/suricata/files/volatiles.03_suricata
rename to meta-security/recipes-ids/suricata/files/volatiles.03_suricata
diff --git a/recipes-ids/suricata/python3-suricata-update_1.3.6.bb b/meta=
-security/recipes-ids/suricata/python3-suricata-update_1.3.6.bb
similarity index 100%
rename from recipes-ids/suricata/python3-suricata-update_1.3.6.bb
rename to meta-security/recipes-ids/suricata/python3-suricata-update_1.3.=
6.bb
diff --git a/recipes-ids/suricata/suricata-crates.inc b/meta-security/rec=
ipes-ids/suricata/suricata-crates.inc
similarity index 100%
rename from recipes-ids/suricata/suricata-crates.inc
rename to meta-security/recipes-ids/suricata/suricata-crates.inc
diff --git a/recipes-ids/suricata/suricata.inc b/meta-security/recipes-id=
s/suricata/suricata.inc
similarity index 100%
rename from recipes-ids/suricata/suricata.inc
rename to meta-security/recipes-ids/suricata/suricata.inc
diff --git a/recipes-ids/suricata/suricata_8.0.6.bb b/meta-security/recip=
es-ids/suricata/suricata_8.0.6.bb
similarity index 100%
rename from recipes-ids/suricata/suricata_8.0.6.bb
rename to meta-security/recipes-ids/suricata/suricata_8.0.6.bb
diff --git a/recipes-kernel/linux/files/lkrg.cfg b/meta-security/recipes-=
kernel/linux/files/lkrg.cfg
similarity index 100%
rename from recipes-kernel/linux/files/lkrg.cfg
rename to meta-security/recipes-kernel/linux/files/lkrg.cfg
diff --git a/recipes-kernel/linux/files/lkrg.scc b/meta-security/recipes-=
kernel/linux/files/lkrg.scc
similarity index 100%
rename from recipes-kernel/linux/files/lkrg.scc
rename to meta-security/recipes-kernel/linux/files/lkrg.scc
diff --git a/recipes-kernel/linux/linux-yocto-rt_%.bbappend b/meta-securi=
ty/recipes-kernel/linux/linux-yocto-rt_%.bbappend
similarity index 100%
rename from recipes-kernel/linux/linux-yocto-rt_%.bbappend
rename to meta-security/recipes-kernel/linux/linux-yocto-rt_%.bbappend
diff --git a/recipes-kernel/linux/linux-yocto_%.bbappend b/meta-security/=
recipes-kernel/linux/linux-yocto_%.bbappend
similarity index 100%
rename from recipes-kernel/linux/linux-yocto_%.bbappend
rename to meta-security/recipes-kernel/linux/linux-yocto_%.bbappend
diff --git a/recipes-kernel/linux/linux-yocto_security.inc b/meta-securit=
y/recipes-kernel/linux/linux-yocto_security.inc
similarity index 100%
rename from recipes-kernel/linux/linux-yocto_security.inc
rename to meta-security/recipes-kernel/linux/linux-yocto_security.inc
diff --git a/recipes-kernel/lkrg/lkrg-module_0.9.7.bb b/meta-security/rec=
ipes-kernel/lkrg/lkrg-module_0.9.7.bb
similarity index 100%
rename from recipes-kernel/lkrg/lkrg-module_0.9.7.bb
rename to meta-security/recipes-kernel/lkrg/lkrg-module_0.9.7.bb
diff --git a/recipes-mac/AppArmor/apparmor_4.0.3.bb b/meta-security/recip=
es-mac/AppArmor/apparmor_4.0.3.bb
similarity index 100%
rename from recipes-mac/AppArmor/apparmor_4.0.3.bb
rename to meta-security/recipes-mac/AppArmor/apparmor_4.0.3.bb
diff --git a/recipes-mac/AppArmor/files/0001-Makefile-fix-hardcoded-insta=
llation-directories.patch b/meta-security/recipes-mac/AppArmor/files/0001=
-Makefile-fix-hardcoded-installation-directories.patch
similarity index 100%
rename from recipes-mac/AppArmor/files/0001-Makefile-fix-hardcoded-instal=
lation-directories.patch
rename to meta-security/recipes-mac/AppArmor/files/0001-Makefile-fix-hard=
coded-installation-directories.patch
diff --git a/recipes-mac/AppArmor/files/0001-Makefile.am-suppress-perlloc=
al.pod.patch b/meta-security/recipes-mac/AppArmor/files/0001-Makefile.am-=
suppress-perllocal.pod.patch
similarity index 100%
rename from recipes-mac/AppArmor/files/0001-Makefile.am-suppress-perlloca=
l.pod.patch
rename to meta-security/recipes-mac/AppArmor/files/0001-Makefile.am-suppr=
ess-perllocal.pod.patch
diff --git a/recipes-mac/AppArmor/files/0001-fail.py-handle-missing-cgitb=
.patch b/meta-security/recipes-mac/AppArmor/files/0001-fail.py-handle-mis=
sing-cgitb.patch
similarity index 100%
rename from recipes-mac/AppArmor/files/0001-fail.py-handle-missing-cgitb.=
patch
rename to meta-security/recipes-mac/AppArmor/files/0001-fail.py-handle-mi=
ssing-cgitb.patch
diff --git a/recipes-mac/AppArmor/files/crosscompile_perl_bindings.patch =
b/meta-security/recipes-mac/AppArmor/files/crosscompile_perl_bindings.pat=
ch
similarity index 100%
rename from recipes-mac/AppArmor/files/crosscompile_perl_bindings.patch
rename to meta-security/recipes-mac/AppArmor/files/crosscompile_perl_bind=
ings.patch
diff --git a/recipes-mac/AppArmor/files/run-ptest b/meta-security/recipes=
-mac/AppArmor/files/run-ptest
similarity index 100%
rename from recipes-mac/AppArmor/files/run-ptest
rename to meta-security/recipes-mac/AppArmor/files/run-ptest
diff --git a/recipes-mac/ccs-tools/README b/meta-security/recipes-mac/ccs=
-tools/README
similarity index 100%
rename from recipes-mac/ccs-tools/README
rename to meta-security/recipes-mac/ccs-tools/README
diff --git a/recipes-mac/ccs-tools/ccs-tools_1.8.14.bb b/meta-security/re=
cipes-mac/ccs-tools/ccs-tools_1.8.14.bb
similarity index 100%
rename from recipes-mac/ccs-tools/ccs-tools_1.8.14.bb
rename to meta-security/recipes-mac/ccs-tools/ccs-tools_1.8.14.bb
diff --git a/recipes-mac/smack/mmap-smack-test/mmap.c b/meta-security/rec=
ipes-mac/smack/mmap-smack-test/mmap.c
similarity index 100%
rename from recipes-mac/smack/mmap-smack-test/mmap.c
rename to meta-security/recipes-mac/smack/mmap-smack-test/mmap.c
diff --git a/recipes-mac/smack/mmap-smack-test_1.0.bb b/meta-security/rec=
ipes-mac/smack/mmap-smack-test_1.0.bb
similarity index 100%
rename from recipes-mac/smack/mmap-smack-test_1.0.bb
rename to meta-security/recipes-mac/smack/mmap-smack-test_1.0.bb
diff --git a/recipes-mac/smack/smack-test/notroot.py b/meta-security/reci=
pes-mac/smack/smack-test/notroot.py
similarity index 100%
rename from recipes-mac/smack/smack-test/notroot.py
rename to meta-security/recipes-mac/smack/smack-test/notroot.py
diff --git a/recipes-mac/smack/smack-test/smack_test_file_access.sh b/met=
a-security/recipes-mac/smack/smack-test/smack_test_file_access.sh
similarity index 100%
rename from recipes-mac/smack/smack-test/smack_test_file_access.sh
rename to meta-security/recipes-mac/smack/smack-test/smack_test_file_acce=
ss.sh
diff --git a/recipes-mac/smack/smack-test/test_privileged_change_self_lab=
el.sh b/meta-security/recipes-mac/smack/smack-test/test_privileged_change=
_self_label.sh
similarity index 100%
rename from recipes-mac/smack/smack-test/test_privileged_change_self_labe=
l.sh
rename to meta-security/recipes-mac/smack/smack-test/test_privileged_chan=
ge_self_label.sh
diff --git a/recipes-mac/smack/smack-test/test_smack_onlycap.sh b/meta-se=
curity/recipes-mac/smack/smack-test/test_smack_onlycap.sh
similarity index 100%
rename from recipes-mac/smack/smack-test/test_smack_onlycap.sh
rename to meta-security/recipes-mac/smack/smack-test/test_smack_onlycap.s=
h
diff --git a/recipes-mac/smack/smack-test_1.0.bb b/meta-security/recipes-=
mac/smack/smack-test_1.0.bb
similarity index 100%
rename from recipes-mac/smack/smack-test_1.0.bb
rename to meta-security/recipes-mac/smack/smack-test_1.0.bb
diff --git a/recipes-mac/smack/smack/run-ptest b/meta-security/recipes-ma=
c/smack/smack/run-ptest
similarity index 100%
rename from recipes-mac/smack/smack/run-ptest
rename to meta-security/recipes-mac/smack/smack/run-ptest
diff --git a/recipes-mac/smack/smack/smack_generator_make_fixup.patch b/m=
eta-security/recipes-mac/smack/smack/smack_generator_make_fixup.patch
similarity index 100%
rename from recipes-mac/smack/smack/smack_generator_make_fixup.patch
rename to meta-security/recipes-mac/smack/smack/smack_generator_make_fixu=
p.patch
diff --git a/recipes-mac/smack/smack_1.3.1.bb b/meta-security/recipes-mac=
/smack/smack_1.3.1.bb
similarity index 100%
rename from recipes-mac/smack/smack_1.3.1.bb
rename to meta-security/recipes-mac/smack/smack_1.3.1.bb
diff --git a/recipes-mac/smack/tcp-smack-test/tcp_client.c b/meta-securit=
y/recipes-mac/smack/tcp-smack-test/tcp_client.c
similarity index 100%
rename from recipes-mac/smack/tcp-smack-test/tcp_client.c
rename to meta-security/recipes-mac/smack/tcp-smack-test/tcp_client.c
diff --git a/recipes-mac/smack/tcp-smack-test/tcp_server.c b/meta-securit=
y/recipes-mac/smack/tcp-smack-test/tcp_server.c
similarity index 100%
rename from recipes-mac/smack/tcp-smack-test/tcp_server.c
rename to meta-security/recipes-mac/smack/tcp-smack-test/tcp_server.c
diff --git a/recipes-mac/smack/tcp-smack-test/test_smack_tcp_sockets.sh b=
/meta-security/recipes-mac/smack/tcp-smack-test/test_smack_tcp_sockets.sh
similarity index 100%
rename from recipes-mac/smack/tcp-smack-test/test_smack_tcp_sockets.sh
rename to meta-security/recipes-mac/smack/tcp-smack-test/test_smack_tcp_s=
ockets.sh
diff --git a/recipes-mac/smack/tcp-smack-test_1.0.bb b/meta-security/reci=
pes-mac/smack/tcp-smack-test_1.0.bb
similarity index 100%
rename from recipes-mac/smack/tcp-smack-test_1.0.bb
rename to meta-security/recipes-mac/smack/tcp-smack-test_1.0.bb
diff --git a/recipes-mac/smack/udp-smack-test/test_smack_udp_sockets.sh b=
/meta-security/recipes-mac/smack/udp-smack-test/test_smack_udp_sockets.sh
similarity index 100%
rename from recipes-mac/smack/udp-smack-test/test_smack_udp_sockets.sh
rename to meta-security/recipes-mac/smack/udp-smack-test/test_smack_udp_s=
ockets.sh
diff --git a/recipes-mac/smack/udp-smack-test/udp_client.c b/meta-securit=
y/recipes-mac/smack/udp-smack-test/udp_client.c
similarity index 100%
rename from recipes-mac/smack/udp-smack-test/udp_client.c
rename to meta-security/recipes-mac/smack/udp-smack-test/udp_client.c
diff --git a/recipes-mac/smack/udp-smack-test/udp_server.c b/meta-securit=
y/recipes-mac/smack/udp-smack-test/udp_server.c
similarity index 100%
rename from recipes-mac/smack/udp-smack-test/udp_server.c
rename to meta-security/recipes-mac/smack/udp-smack-test/udp_server.c
diff --git a/recipes-mac/smack/udp-smack-test_1.0.bb b/meta-security/reci=
pes-mac/smack/udp-smack-test_1.0.bb
similarity index 100%
rename from recipes-mac/smack/udp-smack-test_1.0.bb
rename to meta-security/recipes-mac/smack/udp-smack-test_1.0.bb
diff --git a/recipes-perl/perl/files/libwhisker2.patch b/meta-security/re=
cipes-perl/perl/files/libwhisker2.patch
similarity index 100%
rename from recipes-perl/perl/files/libwhisker2.patch
rename to meta-security/recipes-perl/perl/files/libwhisker2.patch
diff --git a/recipes-perl/perl/lib-perl_0.63.bb b/meta-security/recipes-p=
erl/perl/lib-perl_0.63.bb
similarity index 100%
rename from recipes-perl/perl/lib-perl_0.63.bb
rename to meta-security/recipes-perl/perl/lib-perl_0.63.bb
diff --git a/recipes-perl/perl/libwhisker2-perl_2.5.bb b/meta-security/re=
cipes-perl/perl/libwhisker2-perl_2.5.bb
similarity index 100%
rename from recipes-perl/perl/libwhisker2-perl_2.5.bb
rename to meta-security/recipes-perl/perl/libwhisker2-perl_2.5.bb
diff --git a/recipes-scanners/arpwatch/arpwatch_3.3.bb b/meta-security/re=
cipes-scanners/arpwatch/arpwatch_3.3.bb
similarity index 100%
rename from recipes-scanners/arpwatch/arpwatch_3.3.bb
rename to meta-security/recipes-scanners/arpwatch/arpwatch_3.3.bb
diff --git a/recipes-scanners/arpwatch/files/arpwatch.conf b/meta-securit=
y/recipes-scanners/arpwatch/files/arpwatch.conf
similarity index 100%
rename from recipes-scanners/arpwatch/files/arpwatch.conf
rename to meta-security/recipes-scanners/arpwatch/files/arpwatch.conf
diff --git a/recipes-scanners/arpwatch/files/arpwatch.default b/meta-secu=
rity/recipes-scanners/arpwatch/files/arpwatch.default
similarity index 100%
rename from recipes-scanners/arpwatch/files/arpwatch.default
rename to meta-security/recipes-scanners/arpwatch/files/arpwatch.default
diff --git a/recipes-scanners/arpwatch/files/arpwatch_init b/meta-securit=
y/recipes-scanners/arpwatch/files/arpwatch_init
similarity index 100%
rename from recipes-scanners/arpwatch/files/arpwatch_init
rename to meta-security/recipes-scanners/arpwatch/files/arpwatch_init
diff --git a/recipes-scanners/arpwatch/files/host_contam_fix.patch b/meta=
-security/recipes-scanners/arpwatch/files/host_contam_fix.patch
similarity index 100%
rename from recipes-scanners/arpwatch/files/host_contam_fix.patch
rename to meta-security/recipes-scanners/arpwatch/files/host_contam_fix.p=
atch
diff --git a/recipes-scanners/buck-security/buck-security_0.7.bb b/meta-s=
ecurity/recipes-scanners/buck-security/buck-security_0.7.bb
similarity index 100%
rename from recipes-scanners/buck-security/buck-security_0.7.bb
rename to meta-security/recipes-scanners/buck-security/buck-security_0.7.=
bb
diff --git a/recipes-scanners/checksec/checksec_2.6.0.bb b/meta-security/=
recipes-scanners/checksec/checksec_2.6.0.bb
similarity index 100%
rename from recipes-scanners/checksec/checksec_2.6.0.bb
rename to meta-security/recipes-scanners/checksec/checksec_2.6.0.bb
diff --git a/recipes-scanners/clamav/clamav-crates.inc b/meta-security/re=
cipes-scanners/clamav/clamav-crates.inc
similarity index 100%
rename from recipes-scanners/clamav/clamav-crates.inc
rename to meta-security/recipes-scanners/clamav/clamav-crates.inc
diff --git a/recipes-scanners/clamav/clamav-git-crates.inc b/meta-securit=
y/recipes-scanners/clamav/clamav-git-crates.inc
similarity index 100%
rename from recipes-scanners/clamav/clamav-git-crates.inc
rename to meta-security/recipes-scanners/clamav/clamav-git-crates.inc
diff --git a/recipes-scanners/clamav/clamav_1.5.4.bb b/meta-security/reci=
pes-scanners/clamav/clamav_1.5.4.bb
similarity index 100%
rename from recipes-scanners/clamav/clamav_1.5.4.bb
rename to meta-security/recipes-scanners/clamav/clamav_1.5.4.bb
diff --git a/recipes-scanners/clamav/files/0001-Use-non-deprecated-OpenSS=
L-accessors-for-ASN1_STRING.patch b/meta-security/recipes-scanners/clamav=
/files/0001-Use-non-deprecated-OpenSSL-accessors-for-ASN1_STRING.patch
similarity index 100%
rename from recipes-scanners/clamav/files/0001-Use-non-deprecated-OpenSSL=
-accessors-for-ASN1_STRING.patch
rename to meta-security/recipes-scanners/clamav/files/0001-Use-non-deprec=
ated-OpenSSL-accessors-for-ASN1_STRING.patch
diff --git a/recipes-scanners/clamav/files/clamav-freshclam.service b/met=
a-security/recipes-scanners/clamav/files/clamav-freshclam.service
similarity index 100%
rename from recipes-scanners/clamav/files/clamav-freshclam.service
rename to meta-security/recipes-scanners/clamav/files/clamav-freshclam.se=
rvice
diff --git a/recipes-scanners/clamav/files/clamav-milter.conf.sample b/me=
ta-security/recipes-scanners/clamav/files/clamav-milter.conf.sample
similarity index 100%
rename from recipes-scanners/clamav/files/clamav-milter.conf.sample
rename to meta-security/recipes-scanners/clamav/files/clamav-milter.conf.=
sample
diff --git a/recipes-scanners/clamav/files/clamav.service b/meta-security=
/recipes-scanners/clamav/files/clamav.service
similarity index 100%
rename from recipes-scanners/clamav/files/clamav.service
rename to meta-security/recipes-scanners/clamav/files/clamav.service
diff --git a/recipes-scanners/clamav/files/clamd.conf b/meta-security/rec=
ipes-scanners/clamav/files/clamd.conf
similarity index 100%
rename from recipes-scanners/clamav/files/clamd.conf
rename to meta-security/recipes-scanners/clamav/files/clamd.conf
diff --git a/recipes-scanners/clamav/files/freshclam-native.conf b/meta-s=
ecurity/recipes-scanners/clamav/files/freshclam-native.conf
similarity index 100%
rename from recipes-scanners/clamav/files/freshclam-native.conf
rename to meta-security/recipes-scanners/clamav/files/freshclam-native.co=
nf
diff --git a/recipes-scanners/clamav/files/freshclam.conf b/meta-security=
/recipes-scanners/clamav/files/freshclam.conf
similarity index 100%
rename from recipes-scanners/clamav/files/freshclam.conf
rename to meta-security/recipes-scanners/clamav/files/freshclam.conf
diff --git a/recipes-scanners/clamav/files/tmpfiles.clamav b/meta-securit=
y/recipes-scanners/clamav/files/tmpfiles.clamav
similarity index 100%
rename from recipes-scanners/clamav/files/tmpfiles.clamav
rename to meta-security/recipes-scanners/clamav/files/tmpfiles.clamav
diff --git a/recipes-scanners/clamav/files/volatiles.03_clamav b/meta-sec=
urity/recipes-scanners/clamav/files/volatiles.03_clamav
similarity index 100%
rename from recipes-scanners/clamav/files/volatiles.03_clamav
rename to meta-security/recipes-scanners/clamav/files/volatiles.03_clamav
diff --git a/recipes-scanners/rootkits/chkrootkit_0.58b.bb b/meta-securit=
y/recipes-scanners/rootkits/chkrootkit_0.58b.bb
similarity index 100%
rename from recipes-scanners/rootkits/chkrootkit_0.58b.bb
rename to meta-security/recipes-scanners/rootkits/chkrootkit_0.58b.bb
diff --git a/recipes-scanners/rootkits/files/0001-Fix-building-with-gcc-1=
5.patch b/meta-security/recipes-scanners/rootkits/files/0001-Fix-building=
-with-gcc-15.patch
similarity index 100%
rename from recipes-scanners/rootkits/files/0001-Fix-building-with-gcc-15=
.patch
rename to meta-security/recipes-scanners/rootkits/files/0001-Fix-building=
-with-gcc-15.patch
diff --git a/recipes-scanners/rootkits/files/musl_fix.patch b/meta-securi=
ty/recipes-scanners/rootkits/files/musl_fix.patch
similarity index 100%
rename from recipes-scanners/rootkits/files/musl_fix.patch
rename to meta-security/recipes-scanners/rootkits/files/musl_fix.patch
diff --git a/recipes-security/Firejail/firejail/exclude_seccomp_util_comp=
iles.patch b/meta-security/recipes-security/Firejail/firejail/exclude_sec=
comp_util_compiles.patch
similarity index 100%
rename from recipes-security/Firejail/firejail/exclude_seccomp_util_compi=
les.patch
rename to meta-security/recipes-security/Firejail/firejail/exclude_seccom=
p_util_compiles.patch
diff --git a/recipes-security/Firejail/firejail_0.9.72.bb b/meta-security=
/recipes-security/Firejail/firejail_0.9.72.bb
similarity index 100%
rename from recipes-security/Firejail/firejail_0.9.72.bb
rename to meta-security/recipes-security/Firejail/firejail_0.9.72.bb
diff --git a/recipes-security/aircrack-ng/aircrack-ng/0001-Remove-build-d=
irectory-reference.patch b/meta-security/recipes-security/aircrack-ng/air=
crack-ng/0001-Remove-build-directory-reference.patch
similarity index 100%
rename from recipes-security/aircrack-ng/aircrack-ng/0001-Remove-build-di=
rectory-reference.patch
rename to meta-security/recipes-security/aircrack-ng/aircrack-ng/0001-Rem=
ove-build-directory-reference.patch
diff --git a/recipes-security/aircrack-ng/aircrack-ng_1.7.bb b/meta-secur=
ity/recipes-security/aircrack-ng/aircrack-ng_1.7.bb
similarity index 100%
rename from recipes-security/aircrack-ng/aircrack-ng_1.7.bb
rename to meta-security/recipes-security/aircrack-ng/aircrack-ng_1.7.bb
diff --git a/recipes-security/chipsec/chipsec_1.13.16.bb b/meta-security/=
recipes-security/chipsec/chipsec_1.13.16.bb
similarity index 100%
rename from recipes-security/chipsec/chipsec_1.13.16.bb
rename to meta-security/recipes-security/chipsec/chipsec_1.13.16.bb
diff --git a/recipes-security/cryptmount/cryptmount_6.2.0.bb b/meta-secur=
ity/recipes-security/cryptmount/cryptmount_6.2.0.bb
similarity index 100%
rename from recipes-security/cryptmount/cryptmount_6.2.0.bb
rename to meta-security/recipes-security/cryptmount/cryptmount_6.2.0.bb
diff --git a/recipes-security/ding-libs/ding-libs_0.7.0.bb b/meta-securit=
y/recipes-security/ding-libs/ding-libs_0.7.0.bb
similarity index 100%
rename from recipes-security/ding-libs/ding-libs_0.7.0.bb
rename to meta-security/recipes-security/ding-libs/ding-libs_0.7.0.bb
diff --git a/recipes-security/ecryptfs-utils/ecryptfs-utils_111.bb b/meta=
-security/recipes-security/ecryptfs-utils/ecryptfs-utils_111.bb
similarity index 100%
rename from recipes-security/ecryptfs-utils/ecryptfs-utils_111.bb
rename to meta-security/recipes-security/ecryptfs-utils/ecryptfs-utils_11=
1.bb
diff --git a/recipes-security/ecryptfs-utils/files/0001-avoid-race-condit=
ion.patch b/meta-security/recipes-security/ecryptfs-utils/files/0001-avoi=
d-race-condition.patch
similarity index 100%
rename from recipes-security/ecryptfs-utils/files/0001-avoid-race-conditi=
on.patch
rename to meta-security/recipes-security/ecryptfs-utils/files/0001-avoid-=
race-condition.patch
diff --git a/recipes-security/ecryptfs-utils/files/define_musl_sword_type=
.patch b/meta-security/recipes-security/ecryptfs-utils/files/define_musl_=
sword_type.patch
similarity index 100%
rename from recipes-security/ecryptfs-utils/files/define_musl_sword_type.=
patch
rename to meta-security/recipes-security/ecryptfs-utils/files/define_musl=
_sword_type.patch
diff --git a/recipes-security/ecryptfs-utils/files/ecryptfs-utils-CVE-201=
6-6224.patch b/meta-security/recipes-security/ecryptfs-utils/files/ecrypt=
fs-utils-CVE-2016-6224.patch
similarity index 100%
rename from recipes-security/ecryptfs-utils/files/ecryptfs-utils-CVE-2016=
-6224.patch
rename to meta-security/recipes-security/ecryptfs-utils/files/ecryptfs-ut=
ils-CVE-2016-6224.patch
diff --git a/recipes-security/ecryptfs-utils/files/ecryptfs.service b/met=
a-security/recipes-security/ecryptfs-utils/files/ecryptfs.service
similarity index 100%
rename from recipes-security/ecryptfs-utils/files/ecryptfs.service
rename to meta-security/recipes-security/ecryptfs-utils/files/ecryptfs.se=
rvice
diff --git a/recipes-security/fscrypt/fscrypt_1.1.0.bb b/meta-security/re=
cipes-security/fscrypt/fscrypt_1.1.0.bb
similarity index 100%
rename from recipes-security/fscrypt/fscrypt_1.1.0.bb
rename to meta-security/recipes-security/fscrypt/fscrypt_1.1.0.bb
diff --git a/recipes-security/fscryptctl/fscryptctl_1.1.0.bb b/meta-secur=
ity/recipes-security/fscryptctl/fscryptctl_1.1.0.bb
similarity index 100%
rename from recipes-security/fscryptctl/fscryptctl_1.1.0.bb
rename to meta-security/recipes-security/fscryptctl/fscryptctl_1.1.0.bb
diff --git a/recipes-security/glome/glome_git.bb b/meta-security/recipes-=
security/glome/glome_git.bb
similarity index 100%
rename from recipes-security/glome/glome_git.bb
rename to meta-security/recipes-security/glome/glome_git.bb
diff --git a/recipes-security/google-authenticator-libpam/google-authenti=
cator-libpam_1.11.bb b/meta-security/recipes-security/google-authenticato=
r-libpam/google-authenticator-libpam_1.11.bb
similarity index 100%
rename from recipes-security/google-authenticator-libpam/google-authentic=
ator-libpam_1.11.bb
rename to meta-security/recipes-security/google-authenticator-libpam/goog=
le-authenticator-libpam_1.11.bb
diff --git a/recipes-security/isic/files/configure_fix.patch b/meta-secur=
ity/recipes-security/isic/files/configure_fix.patch
similarity index 100%
rename from recipes-security/isic/files/configure_fix.patch
rename to meta-security/recipes-security/isic/files/configure_fix.patch
diff --git a/recipes-security/isic/files/isic-0.07-make.patch b/meta-secu=
rity/recipes-security/isic/files/isic-0.07-make.patch
similarity index 100%
rename from recipes-security/isic/files/isic-0.07-make.patch
rename to meta-security/recipes-security/isic/files/isic-0.07-make.patch
diff --git a/recipes-security/isic/files/isic-0.07-netinet.patch b/meta-s=
ecurity/recipes-security/isic/files/isic-0.07-netinet.patch
similarity index 100%
rename from recipes-security/isic/files/isic-0.07-netinet.patch
rename to meta-security/recipes-security/isic/files/isic-0.07-netinet.pat=
ch
diff --git a/recipes-security/isic/isic_0.07.bb b/meta-security/recipes-s=
ecurity/isic/isic_0.07.bb
similarity index 100%
rename from recipes-security/isic/isic_0.07.bb
rename to meta-security/recipes-security/isic/isic_0.07.bb
diff --git a/recipes-security/krill/files/0001-Disable-abort-on-panic.pat=
ch b/meta-security/recipes-security/krill/files/0001-Disable-abort-on-pan=
ic.patch
similarity index 100%
rename from recipes-security/krill/files/0001-Disable-abort-on-panic.patc=
h
rename to meta-security/recipes-security/krill/files/0001-Disable-abort-o=
n-panic.patch
diff --git a/recipes-security/krill/files/0002-Update-crate-dependencies.=
patch b/meta-security/recipes-security/krill/files/0002-Update-crate-depe=
ndencies.patch
similarity index 100%
rename from recipes-security/krill/files/0002-Update-crate-dependencies.p=
atch
rename to meta-security/recipes-security/krill/files/0002-Update-crate-de=
pendencies.patch
diff --git a/recipes-security/krill/krill-crates.inc b/meta-security/reci=
pes-security/krill/krill-crates.inc
similarity index 100%
rename from recipes-security/krill/krill-crates.inc
rename to meta-security/recipes-security/krill/krill-crates.inc
diff --git a/recipes-security/krill/krill_0.16.0.bb b/meta-security/recip=
es-security/krill/krill_0.16.0.bb
similarity index 100%
rename from recipes-security/krill/krill_0.16.0.bb
rename to meta-security/recipes-security/krill/krill_0.16.0.bb
diff --git a/recipes-security/libgssglue/files/run-ptest b/meta-security/=
recipes-security/libgssglue/files/run-ptest
similarity index 100%
rename from recipes-security/libgssglue/files/run-ptest
rename to meta-security/recipes-security/libgssglue/files/run-ptest
diff --git a/recipes-security/libgssglue/libgssglue_0.9.bb b/meta-securit=
y/recipes-security/libgssglue/libgssglue_0.9.bb
similarity index 100%
rename from recipes-security/libgssglue/libgssglue_0.9.bb
rename to meta-security/recipes-security/libgssglue/libgssglue_0.9.bb
diff --git a/recipes-security/ncrack/ncrack/0001-fix-ftbfs-with-OpenSSL-4=
.patch b/meta-security/recipes-security/ncrack/ncrack/0001-fix-ftbfs-with=
-OpenSSL-4.patch
similarity index 100%
rename from recipes-security/ncrack/ncrack/0001-fix-ftbfs-with-OpenSSL-4.=
patch
rename to meta-security/recipes-security/ncrack/ncrack/0001-fix-ftbfs-wit=
h-OpenSSL-4.patch
diff --git a/recipes-security/ncrack/ncrack_0.7.bb b/meta-security/recipe=
s-security/ncrack/ncrack_0.7.bb
similarity index 100%
rename from recipes-security/ncrack/ncrack_0.7.bb
rename to meta-security/recipes-security/ncrack/ncrack_0.7.bb
diff --git a/recipes-security/opendnssec/files/0001-Fix-implicit-function=
-declarations.patch b/meta-security/recipes-security/opendnssec/files/000=
1-Fix-implicit-function-declarations.patch
similarity index 100%
rename from recipes-security/opendnssec/files/0001-Fix-implicit-function-=
declarations.patch
rename to meta-security/recipes-security/opendnssec/files/0001-Fix-implic=
it-function-declarations.patch
diff --git a/recipes-security/opendnssec/files/0001-include-utilities.h.p=
atch b/meta-security/recipes-security/opendnssec/files/0001-include-utili=
ties.h.patch
similarity index 100%
rename from recipes-security/opendnssec/files/0001-include-utilities.h.pa=
tch
rename to meta-security/recipes-security/opendnssec/files/0001-include-ut=
ilities.h.patch
diff --git a/recipes-security/opendnssec/files/0002-reorder-header-files-=
and-include-time.h.patch b/meta-security/recipes-security/opendnssec/file=
s/0002-reorder-header-files-and-include-time.h.patch
similarity index 100%
rename from recipes-security/opendnssec/files/0002-reorder-header-files-a=
nd-include-time.h.patch
rename to meta-security/recipes-security/opendnssec/files/0002-reorder-he=
ader-files-and-include-time.h.patch
diff --git a/recipes-security/opendnssec/files/libdns_conf_fix.patch b/me=
ta-security/recipes-security/opendnssec/files/libdns_conf_fix.patch
similarity index 100%
rename from recipes-security/opendnssec/files/libdns_conf_fix.patch
rename to meta-security/recipes-security/opendnssec/files/libdns_conf_fix=
.patch
diff --git a/recipes-security/opendnssec/files/libxml2_conf.patch b/meta-=
security/recipes-security/opendnssec/files/libxml2_conf.patch
similarity index 100%
rename from recipes-security/opendnssec/files/libxml2_conf.patch
rename to meta-security/recipes-security/opendnssec/files/libxml2_conf.pa=
tch
diff --git a/recipes-security/opendnssec/opendnssec_2.1.14.bb b/meta-secu=
rity/recipes-security/opendnssec/opendnssec_2.1.14.bb
similarity index 100%
rename from recipes-security/opendnssec/opendnssec_2.1.14.bb
rename to meta-security/recipes-security/opendnssec/opendnssec_2.1.14.bb
diff --git a/recipes-security/redhat-security/files/find-chroot-py.sh b/m=
eta-security/recipes-security/redhat-security/files/find-chroot-py.sh
similarity index 100%
rename from recipes-security/redhat-security/files/find-chroot-py.sh
rename to meta-security/recipes-security/redhat-security/files/find-chroo=
t-py.sh
diff --git a/recipes-security/redhat-security/files/find-chroot.sh b/meta=
-security/recipes-security/redhat-security/files/find-chroot.sh
similarity index 100%
rename from recipes-security/redhat-security/files/find-chroot.sh
rename to meta-security/recipes-security/redhat-security/files/find-chroo=
t.sh
diff --git a/recipes-security/redhat-security/files/find-elf4tmp.sh b/met=
a-security/recipes-security/redhat-security/files/find-elf4tmp.sh
similarity index 100%
rename from recipes-security/redhat-security/files/find-elf4tmp.sh
rename to meta-security/recipes-security/redhat-security/files/find-elf4t=
mp.sh
diff --git a/recipes-security/redhat-security/files/find-execstack.sh b/m=
eta-security/recipes-security/redhat-security/files/find-execstack.sh
similarity index 100%
rename from recipes-security/redhat-security/files/find-execstack.sh
rename to meta-security/recipes-security/redhat-security/files/find-execs=
tack.sh
diff --git a/recipes-security/redhat-security/files/find-hidden-exec.sh b=
/meta-security/recipes-security/redhat-security/files/find-hidden-exec.sh
similarity index 100%
rename from recipes-security/redhat-security/files/find-hidden-exec.sh
rename to meta-security/recipes-security/redhat-security/files/find-hidde=
n-exec.sh
diff --git a/recipes-security/redhat-security/files/find-nodrop-groups.sh=
 b/meta-security/recipes-security/redhat-security/files/find-nodrop-group=
s.sh
similarity index 100%
rename from recipes-security/redhat-security/files/find-nodrop-groups.sh
rename to meta-security/recipes-security/redhat-security/files/find-nodro=
p-groups.sh
diff --git a/recipes-security/redhat-security/files/find-sh4errors.sh b/m=
eta-security/recipes-security/redhat-security/files/find-sh4errors.sh
similarity index 100%
rename from recipes-security/redhat-security/files/find-sh4errors.sh
rename to meta-security/recipes-security/redhat-security/files/find-sh4er=
rors.sh
diff --git a/recipes-security/redhat-security/files/find-sh4tmp.sh b/meta=
-security/recipes-security/redhat-security/files/find-sh4tmp.sh
similarity index 100%
rename from recipes-security/redhat-security/files/find-sh4tmp.sh
rename to meta-security/recipes-security/redhat-security/files/find-sh4tm=
p.sh
diff --git a/recipes-security/redhat-security/files/lib-bin-check.sh b/me=
ta-security/recipes-security/redhat-security/files/lib-bin-check.sh
similarity index 100%
rename from recipes-security/redhat-security/files/lib-bin-check.sh
rename to meta-security/recipes-security/redhat-security/files/lib-bin-ch=
eck.sh
diff --git a/recipes-security/redhat-security/files/rpm-chksec.sh b/meta-=
security/recipes-security/redhat-security/files/rpm-chksec.sh
similarity index 100%
rename from recipes-security/redhat-security/files/rpm-chksec.sh
rename to meta-security/recipes-security/redhat-security/files/rpm-chksec=
.sh
diff --git a/recipes-security/redhat-security/files/rpm-drop-groups.sh b/=
meta-security/recipes-security/redhat-security/files/rpm-drop-groups.sh
similarity index 100%
rename from recipes-security/redhat-security/files/rpm-drop-groups.sh
rename to meta-security/recipes-security/redhat-security/files/rpm-drop-g=
roups.sh
diff --git a/recipes-security/redhat-security/files/selinux-check-devices=
.sh b/meta-security/recipes-security/redhat-security/files/selinux-check-=
devices.sh
similarity index 100%
rename from recipes-security/redhat-security/files/selinux-check-devices.=
sh
rename to meta-security/recipes-security/redhat-security/files/selinux-ch=
eck-devices.sh
diff --git a/recipes-security/redhat-security/files/selinux-ls-unconfined=
.sh b/meta-security/recipes-security/redhat-security/files/selinux-ls-unc=
onfined.sh
similarity index 100%
rename from recipes-security/redhat-security/files/selinux-ls-unconfined.=
sh
rename to meta-security/recipes-security/redhat-security/files/selinux-ls=
-unconfined.sh
diff --git a/recipes-security/redhat-security/redhat-security_1.0.bb b/me=
ta-security/recipes-security/redhat-security/redhat-security_1.0.bb
similarity index 100%
rename from recipes-security/redhat-security/redhat-security_1.0.bb
rename to meta-security/recipes-security/redhat-security/redhat-security_=
1.0.bb
diff --git a/recipes-security/sshguard/sshguard_2.5.1.bb b/meta-security/=
recipes-security/sshguard/sshguard_2.5.1.bb
similarity index 100%
rename from recipes-security/sshguard/sshguard_2.5.1.bb
rename to meta-security/recipes-security/sshguard/sshguard_2.5.1.bb
diff --git a/scripts/ci-cleanup.sh b/meta-security/scripts/ci-cleanup.sh
similarity index 100%
rename from scripts/ci-cleanup.sh
rename to meta-security/scripts/ci-cleanup.sh
diff --git a/scripts/upload-error-report b/meta-security/scripts/upload-e=
rror-report
similarity index 100%
rename from scripts/upload-error-report
rename to meta-security/scripts/upload-error-report
--=20
2.56.1


Return-Path: <louis.rannou@semalibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EC4CDE032
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 08:30:08 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13576.1763109006259240414
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Nov 2025 00:30:06 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: no key for signature: lookup dkim._domainkey.semalibre.com on 100.100.100.100:53: no such host" header.i=@semalibre.com header.s=dkim header.b=FYl8ePLI;
 spf=pass (domain: semalibre.com, ip: 185.246.85.4, mailfrom: louis.rannou@semalibre.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id EB8114E416B5;
	Fri, 14 Nov 2025 08:30:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C09696060E;
	Fri, 14 Nov 2025 08:30:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6CB5A102F2A6F;
	Fri, 14 Nov 2025 09:30:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=semalibre.com;
	s=dkim; t=1763109004;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zlvB2kLW5lVeucoyc3EFFGxpJ6Ur15dDHXdCydobXu4=;
	b=FYl8ePLIyNgOgM+HF1v+H0B8rvxhey3AqmQl/Kz/NBZlePjw8Z5OIZT2Rh0qZq+qbhArGG
	VWFpw8TpVD3SheyOl81scmzqsnpM5CZtu6zjsvVnl8wB5WpvVxD2n6a0yO5TJoVaOoAh2A
	2bOCS8Yf7wZOPdSvcBRl0s2k6VTjVHLJmWsTS29yFwzsiiBdXnJifIPV/Zr8Eo/RWnuFgl
	l8VIgv7DWwrpuDTgGc7AWnfmaZB1q7rp1cso69uIyP9Z04+8TewD0D3gtqeWdz1bnG0+d+
	CxdBaVd4d5O2UsLUJOvAU/2rAjbsDEeO3dczqdq/HexZNGRAxuaXDkXyAPGNGw==
From: Louis Rannou <louis.rannou@semalibre.com>
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com,
	rybczynska@gmail.com,
	pascal.eberhard@non.se.com,
	yi.zhao@windriver.com,
	Louis Rannou <louis.rannou@non.se.com>
Subject: [meta-security][PATCH 2/4] scap-security-guide: update to 0.1.78
Date: Fri, 14 Nov 2025 09:29:48 +0100
Message-ID: <20251114-openscap_bump-v1-2-1c8169b8e332@non.se.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251114-openscap_bump-v1-0-1c8169b8e332@non.se.com>
References: <20251114-openscap_bump-v1-0-1c8169b8e332@non.se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 08:30:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2555

From: Louis Rannou <louis.rannou@non.se.com>

New in 0.1.78 (2025-09-05):
  https://github.com/ComplianceAsCode/content/releases/tag/v0.1.78

Important Highlights

    Enable SCE content for problematic rules that can traverse the whole =
filesystem (#13758)
    Remove unnecessary Jinja2 macros in control files (#13592)
    Update RHEL 8 STIG to V2R4 (#13774)
    Update RHEL 9 STIG to V2R5 (#13795)
    Add CIS benchmark support for debian (#13712)
    Add Debian 13 profile for ANSSI BP 28 (enhanced) (#13571)
    Create SLE Micro 5 General profile (#13490)
    Update the way in which the stable branch is maintained (#13769)

New Rules and Profiles

    add anssi BP28 high profile to debian13 product (#13603)
    Debian13 ANSSI BP28 (minimal) (#13540)
    Debian13: add BP28 intermediary profile (#13556)
    Implement rpm_verify_crypto_policies (#13469)
    Update RHEL 8 STIG to V2R4 (#13774)
        Create slmicro6 product (#13570)

Updated Rules and Profiles

    RHEL 9 STIG: align login timeout with the STIG policy (#13826)
    [Ubuntu 24.04]: Add vlock_installed pkg override (#13582)
    [Ubuntu] Define firewall varriable for Ubuntu 2404 STIG (#13689)
    Add CCE for rsyncd disabled rule to slmicro5 (#13523)
    Add distributed config support (#13653)
    Adjust description of file_permissions_sudo (#13685)
    Fix GRUB 2 UEFI selections in RHEL 9 ANSSI profiles (#13598)
    Fix(accounts_tmout): OVAL check incorrectly passes for TMOUT=3D0 (#13=
564)
    Move RHEL 8 STIG to Control file (#13481)
    Move RHEL 9 ISM O Profile to Control File (#13511)
    Remove rule from OL09-00-001085 (#13673)
    RHEL 9 CIS: add ensure_gpgcheck_never_disabled (#13706)
    RHEL 9 CIS: complete 6.3.3.5 (#13707)
    Set var_screensaver_lock_delay for OL9 (#13672)
    Slmicro5 disable ipv6 rules (#13524)
    Fix bsi conflicts (#13847)
    stop using fixfiles relabel in remediations (#13738)
    Support drop-in files in coredump rules (#13665)
    Update OL10 profiles (#13569)
    Update var_password_pam_unix_rounds for OL9 stig control (#13516)
    Use default order in configure_gnutls_tls_crypto_policy (#13692)

Removed Products

    Remove leftover from ubuntu2004 (#13604)
    Remove Ubuntu 16.04, 18.04 and 20.04 products (#13483)

Changes in Remediations

    RHEL 9 Ansible replace systemd_service module with systemd (#13829)
    Add OL9 to platform in ssh ciphers rule's bash (#13506)
    Enable audit configure rules for slmicro5 (#13525)
    Ensure tmout.sh and ssh_confirm.sh have correct permissions on creati=
on (#13711)
    Exclude remote mounted filesystems from local partition nodev tasks (=
#13530)
    Fix architecture dependent path (#13714)
    Implement mount_option_tmp_noexec for slmicro5 platform (#13509)
    Implement oval and remediation files to tftp_uses_secure_mode_systemd=
 (#13694)
    Prevent fails in check mode (#13703)
    Prevent problems with single quotes (#13742)
    Reduce gathering facts in profile Ansible Playbooks (#13739)
    Remove file_owner_var_log_messages bash remediation (#13488)
    SLE fixes for gid-related rules (#13779)
    SLE improve require_singleuser_auth oval check and remediations (#137=
46)
    stop using fixfiles relabel in remediations (#13738)
    Support banner with single quote (#13713)
    Update ansible for auditd_data_retention_action_mail_acct (#13650)
    Update ansible in require_singleuser_auth for OL (#13651)
    Update disable_users_coredumps rule to support drop-in and string val=
ues (#13749)
    Update jinja in require_emergency_target_auth for OL (#13652)
    Use fully qualified collection name in Ansible tasks (#13794)
    Workaround OpenSCAP issue for Image Mode (#13645)

Changes in Checks

    [Ubuntu] Fix rule encrypt_partitions (#13596)
    Add OL9 in oval to directory_permissions_var_log_audit rule (#13745)
    Add oval check for prevent_direct_root_logins (#13615)
    Add OVAL for encrypt_partitions rule (#13539)
    Allow spaces around equal sign (#13691)
    Create slmicro6 product (#13570)
    Disable value of zero in dconf_gnome_screensaver_idle_delay (#13671)
    Enable multi_platform_sle platforms for encrypt_partition oval check =
(#13775)
    Exclude remote mounted filesystems from local partition nodev tasks (=
#13530)
    Fix(accounts_tmout): OVAL check incorrectly passes for TMOUT=3D0 (#13=
564)
    Fix(OVAL): Correct variable reference in account_disable_inactivity_*=
 (#13591)
    Implement mount_option_tmp_noexec for slmicro5 platform (#13509)
    Implement oval and remediation files to tftp_uses_secure_mode_systemd=
 (#13694)
    Improve OVAL checks for nss-altfiles (#13759)
    Make sure oval service disable macro covers also not found definition=
 (#13725)
    SLE fixes for gid-related rules (#13779)
    SLE improve require_singleuser_auth oval check and remediations (#137=
46)
    SLE kernel package may be called kernel-default-base (#13748)
    Sshd rekey limit update OVAL (#13687)
    Update disable_users_coredumps rule to support drop-in and string val=
ues (#13749)
    Update path for OL9 in sysctl_kernel_exec_shield oval file (#13538)
    Update sshd_set_idle_timeout oval file & sshd_lineinfile template for=
 OL (#13695)

Changes in the Infrastructure

    [workflow] Fix ansible for Ubuntu workflow (#13480)
    Add the ability built more than one product with SRG XLSX Option (#13=
693)
    Fix Debian 13 in CI (#13557)
    Fix level inheritance when processing profiles (#13666)
    Fix SCAP Delta Tailoring (#13542)
    Format rhel8 related yaml files (#13621)
    Improve reproducibility and stability (#13531)
    Move RHEL 9 E8 profile to use the e8 control file (#13482)
    Pre-load Jinja macros (#13502)
    Remove 2 functions (#13659)
    Remove Ubuntu 16.04, 18.04 and 20.04 products (#13483)
    Update Export SRG Script (#13474)

Changes in the Test Suite

    [Ubuntu] Fix test of package_bind_removed (#13560)
    Add missing profile stability data (#13600)
    Add OL9 to disable_ctrlaltdel_reboot tests (#13609)
    Add tags to test scenarios in accounts_root_path_dirs_no_write (#1353=
6)
    Change TS in networkmanager_dns_mode from fail to pass (#13724)
    CI: fedora gating - collapse the multiline command (#13735)
    file_groupownership_system_commands_dirs fix test scenario (#13675)
    Fix platform tag in test scenarios (#13534)
    Fix tests for rule grub2_pti_argument (#13733)
    Update profile to variable in banner_etc_issue_disa_dod_short test (#=
13667)

Documentation

    Remove outdated Code Climate badage (#13744)
    Update Contributors for 0.1.78 (#13807)

Fixed Bugs

    RHEL 9 STIG: align login timeout with the STIG policy (#13826)
    [stabilization]: auditd_lineinfile: allow specifying data type of XCC=
DF variable (#13841)
    RHEL 9 Ansible replace systemd_service module with systemd (#13829)
    [Ubuntu] Remove non-ascii character (#13607)
    Add var_sudo_timestamp_timeout=3Dalways_prompt to RHEL 9 and RHEL 10 =
STIG (#13517)
    Adjust description of file_permissions_sudo (#13685)
    Allow spaces around equal sign (#13691)
    file_groupownership_system_commands_dirs fix test scenario (#13675)
    Fix rule auditd_freq (#13718)
    grub2_*_admin_username: make regex less strict (#13740)
    Install package polkit-pkla-compat (#13729)
    make service_rngd_enabled applicable in case FIPS mode is not enabled=
 (#13705)
    Remove remaining dependencies on installed_OS_is_FIPS_certified (#137=
57)
    replace instances of grub-mkconfig with correct grub2-mkconfig (#1364=
0)
    sshd_limit_user_access is missing the opening tag (#13616)
    stop using fixfiles relabel in remediations (#13738)
    Support drop-in files in coredump rules (#13665)
    Update links which pointed to outdated documentation (#13508)
    Update the suffix for rules used when generating components gh pages =
(#13597)
    Use default order in configure_gnutls_tls_crypto_policy (#13692)
    Use template in grub2_nousb_argument (#13726)

Signed-off-by: Louis Rannou <louis.rannou@non.se.com>
---
 .../{scap-security-guide_0.1.77.bb =3D> scap-security-guide_0.1.78.bb}  =
  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0=
.1.77.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1=
.78.bb
similarity index 96%
rename from recipes-compliance/scap-security-guide/scap-security-guide_0.=
1.77.bb
rename to recipes-compliance/scap-security-guide/scap-security-guide_0.1.=
78.bb
index cdd22a5..8489218 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.77.b=
b
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.b=
b
@@ -6,7 +6,7 @@ HOME_URL =3D "https://www.open-scap.org/security-policies=
/scap-security-guide/"
 LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D9bfa86579213cb4c6adaffface6b2=
820"
 LICENSE =3D "BSD-3-Clause"
=20
-SRCREV =3D "c1e1ba121d32b3c319b0e25ee2993b62386e5857"
+SRCREV =3D "f7d794851971087db77d4be8eeb716944a1aae21"
 SRC_URI =3D "git://github.com/ComplianceAsCode/content.git;nobranch=3D1;=
protocol=3Dhttps \
            file://run_eval.sh \
            "

--=20
2.43.0


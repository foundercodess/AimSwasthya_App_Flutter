import 'package:aim_swasthya/utils/load_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

import '../../../res/appbar_const.dart';
import '../../../view_model/user/tc_pp_view_model.dart';

class TermsOfUserScreen extends StatefulWidget {
  final String type;
  const TermsOfUserScreen({super.key, required this.type});

  @override
  State<TermsOfUserScreen> createState() => _TermsOfUserScreenState();
}

class _TermsOfUserScreenState extends State<TermsOfUserScreen> {
  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     Provider.of<TCPPViewModel>(context, listen: false).getTC(widget.type);
  //   });
  //   super.initState();
  // }

  final privacyPolicy = """
<h1><a name="_Toc188970653">Privacy Policy</a></h1>

<p>&nbsp;</p>

<p>AIMSwasthya Private Limited (&ldquo;us&rdquo;, &ldquo;we&rdquo;, or &ldquo;AIMSwasthya&rdquo;, which also includes its affiliates) is the author and publisher of the internet resource <a href="http://www.aimswasthya.in">www.aimswasthya.in</a> (&ldquo;Website&rdquo;) on the world wide web as well as the software, services and applications provided by AIMSwasthya, including but not limited to the mobile application &lsquo;AIMSwasthya&rsquo; (together with the Website, referred to as the &ldquo;Services&rdquo;).</p>

<p>This privacy policy (&quot;<strong>Privacy Policy</strong>&quot;) explains how we collect, use, share, disclose and protect Personal information about the Users of the Services, including the Practitioners (as defined in the Terms of Use, which may be accessed via the following weblink [.] (the &ldquo;Terms of Use&rdquo;)), the End-Users (as defined in the Terms of Use), and the visitors of Website (jointly and severally referred to as &ldquo;you&rdquo; or &ldquo;Users&rdquo; in this Privacy Policy). We created this Privacy Policy to demonstrate our commitment to the protection of your privacy and your personal information. Your use of and access to the Services is subject to this Privacy Policy and our Terms of Use. Any capitalized term used but not defined in this Privacy Policy shall have the meaning attributed to it in our Terms of Use.</p>

<p>BY USING THE SERVICES OR BY OTHERWISE GIVING US YOUR INFORMATION, YOU WILL BE DEEMED TO HAVE READ, UNDERSTOOD AND AGREED TO THE PRACTICES AND POLICIES OUTLINED IN THIS PRIVACY POLICY AND AGREE TO BE BOUND BY THE PRIVACY POLICY. YOU HEREBY CONSENT TO OUR COLLECTION, USE AND SHARING, DISCLOSURE OF YOUR INFORMATION AS DESCRIBED IN THIS PRIVACY POLICY. WE RESERVE THE RIGHT TO CHANGE, MODIFY, ADD OR DELETE PORTIONS OF THE TERMS OF THIS PRIVACY POLICY, AT OUR SOLE DISCRETION, AT ANY TIME. IF YOU DO NOT AGREE WITH THIS PRIVACY POLICY AT ANY TIME, DO NOT USE ANY OF THE SERVICES OR GIVE US ANY OF YOUR INFORMATION. IF YOU USE THE SERVICES ON BEHALF OF SOMEONE ELSE (SUCH AS YOUR CHILD) OR AN ENTITY (SUCH AS YOUR EMPLOYER), YOU REPRESENT THAT YOU ARE AUTHORISED BY SUCH INDIVIDUAL OR ENTITY TO (I) ACCEPT THIS PRIVACY POLICY ON SUCH INDIVIDUAL&rsquo;S OR ENTITY&rsquo;S BEHALF, AND (II) CONSENT ON BEHALF OF SUCH INDIVIDUAL OR ENTITY TO OUR COLLECTION, USE AND DISCLOSURE OF SUCH INDIVIDUAL&rsquo;S OR ENTITY&rsquo;S INFORMATION AS DESCRIBED IN THIS PRIVACY POLICY.</p>

<p>&nbsp;</p>

<p><a href="#_Toc188970654">1. Overview &amp; Privacy Statements. 2</a></p>

<p><a href="#_Toc188970655">2. Data Collection and Uses. 5</a></p>

<p><a href="#_Toc188970656">A. Data we collect &amp; its purpose. 5</a></p>

<p><a href="#_Toc188970657">B. Data Security. 7</a></p>

<p><a href="#_Toc188970658">C. Core automated process. 8</a></p>

<p><a href="#_Toc188970659">D. Cookies and related technologies. 8</a></p>

<p><a href="#_Toc188970660">E. Data sharing and disclosure. 9</a></p>

<p><a href="#_Toc188970661">F. Data retention and deletion. 9</a></p>

<p><a href="#_Toc188970662">3. Legal Information. 10</a></p>

<p><a href="#_Toc188970663">A. Data Controllers &amp; Data Protection Officers. 10</a></p>

<p><a href="#_Toc188970664">B. Grievance Redressal Mechanism.. 10</a></p>

<p><a href="#_Toc188970665">C. Updates to this Privacy Policy. 11</a></p>

<p>&nbsp;</p>

<h2><a name="_Toc188970654">1. Overview &amp; Privacy Statements</a></h2>

<p><strong>A</strong>. This Privacy Policy is published in compliance with, inter alia:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>

<ol>
	<li>Information Technology Act, 2000;</li>
	<li>Information Technology (Reasonable Security Practices and Procedures and Sensitive Personal Information) Rules, 2011 (the &ldquo;SPI Rules&rdquo;);</li>
	<li>Information Technology (Intermediaries Guidelines) Rules, 2011.</li>
	<li>Information Technology (Intermediary Guidelines and Digital Media Ethics Code) Rules, 2021</li>
	<li>Digital Personal Data Protection Act, 2023</li>
</ol>

<p><strong>B</strong>. This Privacy Policy states the following:</p>

<ol>
	<li>The type of information collected from the Users, including Personal Information (as defined in paragraph 2 below) and Sensitive Personal Data or Information (as defined in paragraph 2 below) relating to an individual;</li>
	<li>The purpose, means and modes of collection, usage, processing, retention and destruction of such information; and</li>
	<li>How and to whom AIMSwasthya will disclose such information.</li>
</ol>

<p><strong>C</strong>. A condition of each User&rsquo;s use of and access to the Services is their acceptance of the Terms of Use, which also involves acceptance of the terms of this Privacy Policy. Any User that does not agree with any provisions of the same has the option to discontinue the Services provided by AIMSwasthya immediately.</p>

<p><strong>D</strong>. Collection, use and disclosure of information which has been designated as Personal Information or Sensitive Personal Data or Information&rsquo; under the SPI Rules requires your express consent. By affirming your assent to this Privacy Policy, you provide your consent to such use, collection and disclosure as required under applicable law.</p>

<p><strong>E.</strong> AIMSwasthya does not control or endorse the content, messages or information found in any Services and, therefore, AIMSwasthya specifically disclaims any liability with regard to the Services and any actions resulting from your participation in any Services, and you agree that you waive any claims against AIMSwasthya relating to same, and to the extent such waiver may be ineffective, you agree to release any claims against AIMSwasthya relating to the same.</p>

<p><strong>F</strong>. You are responsible for maintaining the accuracy of the information you submit to us, such as your contact information provided as part of account registration. If your personal information changes, you may correct, delete inaccuracies, or amend information by making the change on our member information page or by contacting us through [.]. We will make good faith efforts to make requested changes in our then active databases as soon as reasonably practicable. If you provide any information that is untrue, inaccurate, out of date or incomplete (or becomes untrue, inaccurate, out of date or incomplete), or AIMSwasthya has reasonable grounds to suspect that the information provided by you is untrue, inaccurate, out of date or incomplete, AIMSwasthya may, at its sole discretion, discontinue the provision of the Services to you. There may be circumstances where AIMSwasthya will not correct, delete or update your Personal Data, including (a) where the Personal Data is opinion data that is kept solely for evaluative purpose; and (b) the Personal Data is in documents related to a prosecution if all proceedings relating to the prosecution have not been completed.</p>

<p><strong>G.</strong> If you wish to cancel your account or request that we no longer use your information to provide you Services, contact us through [.]. We will retain your information for as long as your account with the Services is active and as needed to provide you the Services. We shall not retain such information for longer than is required for the purposes for which the information may lawfully be used or is otherwise required under any other law for the time being in force. After a period of time, your data may be anonymized and aggregated, and then may be held by us as long as necessary for us to provide our Services effectively, but our use of the anonymized data will be solely for analytic purposes. Please note that your withdrawal of consent, or cancellation of account may result in AIMSwasthya being unable to provide you with its Services or to terminate any existing relationship AIMSwasthya may have with you.</p>

<p><strong>H.</strong> If you wish to opt-out of receiving non-essential communications such as promotional and marketing-related information regarding the Services, please send us an email at [.]/</p>

<p><strong>I.</strong> AIMSwasthya may require the User to pay with a credit card, wire transfer, debit card or cheque for Services for which subscription amount(s) is/are payable. AIMSwasthya will collect such User&rsquo;s credit card number and/or other financial institution information such as bank account numbers and will use that information for the billing and payment processes, including but not limited to the use and disclosure of such credit card number and information to third parties as necessary to complete such billing operation. Verification of credit information, however, is accomplished solely by the User through the authentication process. User&rsquo;s credit-card/debit card details are transacted upon secure sites of approved payment gateways which are digitally under encryption, thereby providing the highest possible degree of care as per current technology. However, AIMSwasthya provides you an option not to save your payment details. User is advised, however, that internet technology is not full proof safe and User should exercise discretion on using the same.</p>

<p><strong>J.</strong> AIMSwasthya does not exercise control over the sites displayed as search results or links from within its Services. These other sites may place their own cookies or other files on the Users&rsquo; computer, collect data or solicit personal information from the Users, for which AIMSwasthya is not responsible or liable. Accordingly, AIMSwasthya does not make any representations concerning the privacy practices or policies of such third parties or terms of use of such websites, nor does AIMSwasthya guarantee the accuracy, integrity, or quality of the information, data, text, software, sound, photographs, graphics, videos, messages or other materials available on such websites. The inclusion or exclusion does not imply any endorsement by AIMSwasthya of the website, the website&#39;s provider, or the information on the website. If you decide to visit a third party website linked to the Website, you do this entirely at your own risk. AIMSwasthya encourages the User to read the privacy policies of that website.</p>

<p><strong>K</strong>. The Website may enable User to communicate with other Users or to post information to be accessed by others, whereupon other Users may collect such data. Such Users, including any moderators or administrators, are not authorized AIMSwasthya representatives or agents, and their opinions or statements do not necessarily reflect those of AIMSwasthya, and they are not authorized to bind AIMSwasthya to any contract. AIMSwasthya hereby expressly disclaims any liability for any reliance or misuse of such information that is made available by Users or visitors in such a manner.</p>

<p><strong>L</strong>. AIMSwasthya does not collect information about the visitors of the Website from other sources, such as public records or bodies, or private organisations, save and except for the purposes of registration of the Users (the collection, use, storage and disclosure of which each End User must agree to under the Terms of Use in order for AIMSwasthya to effectively render the Services).</p>

<p>&nbsp;</p>

<h2><a name="_Toc188970655">2. Data Collection and Uses</a></h2>

<h3><a name="_Toc188970656">A. Data we collect &amp; its purpose</a></h3>

<p>Generally, the Services require us to know who you are so that we can best meet your needs. When you access the Services, or through any interaction with us via emails, telephone calls or other correspondence, we may ask you to voluntarily provide us with certain information that personally identifies you or could be used to personally identify you. You hereby consent to the collection of such information by AIMSwasthya. Without prejudice to the generality of the above, information collected by us from you may include (but is not limited to) the following:</p>

<ul>
	<li>contact data (such as your email address and phone number);</li>
	<li>demographic data (such as your gender, your date of birth and your pin code);</li>
	<li>Government issues identification documents, such as your Aadhar Card</li>
	<li>data regarding your usage of the services and history of the appointments made by or with you through the use of Services;</li>
	<li>medical symptoms logged in by you and your medical history;</li>
	<li>insurance data (such as your insurance carrier and insurance plan);</li>
	<li>other information that you voluntarily choose to provide to us (such as information shared by you with us through emails or letters) including any images and other documents/files.</li>
	<li>data shared by the Practitioners pertaining to the treatment availed by you.</li>
	<li>Payment method (including related payment verification information)</li>
	<li>AIMSwasthya Digital Health Card</li>
	<li>Device IP address or other unique device identifiers</li>
	<li>Advertising identifiers</li>
	<li>Evidence relating to any claims, conflicts or disputes</li>
</ul>

<p>The information collected from you by AIMSwasthya may constitute &lsquo;<strong>personal information</strong>&rsquo; or &lsquo;sensitive personal data or information&rsquo; under the SPI Rules. AIMAwasthya will be free to use, collect and disclose information that is freely available in the public domain without your consent.</p>

<p>All the information provided to AIMSwasthya by a User, including Personal Information or any Sensitive Personal Data or Information, is voluntary. You understand that AIMSwasthya may use certain information of yours, which has been designated as Personal Information or &lsquo;Sensitive Personal Data or Information&rsquo; under the SPI Rules, (a) for the purpose of providing you the Services, (b) for commercial purposes and in an aggregated or non-personally identifiable form for research, statistical analysis and business intelligence purposes, (c) for sale or transfer of such research, statistical or intelligence data in an aggregated or non-personally identifiable form to third parties and affiliates (d) for communication purpose so as to provide You a better way of booking appointments and for obtaining feedback in relation to the Practitioners and their practice, (e) debugging customer support related issues, (f) for the purpose of contacting you to complete any transaction if you do not complete a transaction after having provided us with your contact information in the course of completing such steps that are designed for completion of the transaction.</p>

<p>AIMSwasthya also reserves the right to use information provided by or about the End-User for the following purposes:</p>

<ol>
	<li>Identifying You.</li>
	<li>Publishing such information on the Website.</li>
	<li>Contacting End-Users for offering new products or services.</li>
	<li>Contacting End-Users for taking product and Service feedback.</li>
	<li>Analyzing software usage patterns for improving product design and utility.</li>
	<li>Analyzing anonymized practice information for commercial use.</li>
	<li>Processing payment instructions including those through independent third party service providers such as payment gateways, banking and financial institutions, pre-paid instrument and wallet providers for processing of payment transaction or deferral of payment facilities.</li>
</ol>

<p>By accessing and using the Website and/or verifying your contact number with AIMSwasthya, You have explicitly consented to receive all above stated communications (through call, SMS, email or other digital and electronic means) from AIMSwasthya and/or its authorized representatives, even if your contact number is registered under the DND / NCPR list under the Telecom Commercial Communications Customer Preference Regulations, 2018. For this purpose, the required information may be shared with third-party service providers or any affiliates, group companies, and their authorized agents.</p>

<h3><a name="_Toc188970657">B. Data Security</a></h3>

<p>1. AIMSwasthya has implemented best international market practices and security policies, rules and technical measures to protect the personal data that it has under its control from unauthorised access, improper use or disclosure, unauthorised modification and unlawful destruction or accidental loss. However, for any data loss or theft due to unauthorized access to the User&rsquo;s electronic devices through which the User avails the Services, AIMSwasthya shall not be held liable for any loss whatsoever incurred by the User.</p>

<p>2. AIMSwasthya implements reasonable security practices and procedures and has a comprehensive documented information security programme and information security policies that contain managerial, technical, operational and physical security control measures that are commensurate with respect to the information being collected and the nature of AIMSwasthya&rsquo;s business.</p>

<p>3. AIMSwasthya takes your right to privacy very seriously and other than as specifically stated in this Privacy Policy, will only disclose your Personal Information in the event it is required to do so by law, rule, regulation, law enforcement agency, governmental official, legal authority or similar requirements or when AIMSwasthya, in its sole discretion, deems it necessary in order to protect its rights or the rights of others, to prevent harm to persons or property, to fight fraud and credit risk, or to enforce or apply the Terms of Use.</p>

<h3><a name="_Toc188970658">C. Core automated process</a></h3>

<p>AIMSwasthya uses automated processes powered by artificial intelligence to enable essential parts of our services, including matching end-user symptoms to potential medical conditions and recommending appropriate specialists from the medical field. These automated processes are integral to providing accurate, personalized, and efficient healthcare recommendations, ensuring users receive timely and relevant guidance. This section explains how our automated matching and recommendation processes work, how they enhance your AIMSwasthya experience, and the personal and non-personal data used to enable these processes.</p>

<ul>
	<li><strong>Matching:</strong> AIMSwasthya employs advanced algorithms to efficiently match user symptoms with potential medical conditions and recommend suitable specialists. This ensures that users receive timely and accurate guidance tailored to their needs. The matching process is initiated when a user provides their symptoms through the AIMSwasthya platform. Our algorithms evaluate multiple factors, such as the input symptoms, medical history, user location, the availability of specialists, and their expertise. This process helps ensure precise matches and a seamless experience for the user.</li>
	<li><strong>Pricing:</strong> Pricing is based solely on the specialist&#39;s consultation fees. AIMSwasthya does not charge any additional fees to end-users, ensuring a transparent and fair pricing structure.</li>
	<li><strong>Fraud Prevention and Detection</strong>: AIMSwasthya uses algorithms and machine learning models to prevent and detect fraudulent activities on the platform. This includes monitoring for suspicious behaviors, unauthorized access attempts, or any misuse of the platform.</li>
</ul>

<h3><a name="_Toc188970659">D. Cookies and related technologies</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h3>

<p>Cookies are small text files stored on browsers or devices by websites, apps, online media, and ads. AIMSwasthya uses cookies and similar technologies for various purposes, including:</p>

<ul>
	<li>Authenticating users</li>
	<li>Remembering user preferences and settings</li>
	<li>Determining the popularity of content</li>
	<li>Delivering and measuring the effectiveness of advertising campaigns</li>
	<li>Analyzing site traffic, trends, and understanding user behaviors and interests.</li>
</ul>

<p>We may also work with third parties to provide audience measurement and analytics services, serve ads on our behalf across the internet, and track the performance of those ads. These third parties may use cookies, web beacons, SDKs, and other technologies to identify devices used by visitors to our websites or their interactions with other online sites and services.</p>

<p>Additionally, AIMSwasthya employs temporary cookies to store non-sensitive data for purposes such as technical administration of the website, research and development, and user management. Authorized third parties may place or recognize a unique cookie on a user&rsquo;s browser while serving advertisements or optimizing services. However, these cookies do not store any personal information of the user.</p>

<p>You may adjust your internet browser settings to disable cookies. While this will not prevent you from using the website, some features may be limited.</p>

<h3><a name="_Toc188970660">E. Data sharing and disclosure</a></h3>

<h3><a name="_Toc188970661">F. Data retention and deletion</a></h3>

<p>AIMSwasthya retains your data for as long as necessary to fulfill the purposes outlined above. The retention period varies depending on the type of data, the category of user, the purposes for which the data was collected, and any requirements to retain the data after an account deletion request for compliance or other legitimate purposes.</p>

<p>For instance:</p>

<ul>
	<li>We retain data for the life of your account if it is necessary to provide our services, such as medical consultation records or account-related information.</li>
	<li>We retain certain data for defined periods to comply with tax, legal, insurance, or regulatory requirements.</li>
</ul>

<p>You may request deletion of your account through the AIMSwasthya app or website.</p>

<p>Following an account deletion request, AIMSwasthya deletes your account and data unless retention is necessary for safety, fraud prevention, compliance with legal requirements, or to resolve outstanding matters related to your account (such as unresolved claims, disputes, or payment issues). In most cases, data is deleted within 90 days of an account deletion request, except where extended retention is required for the reasons stated above.</p>

<p>&nbsp;</p>

<h2><a name="_Toc188970662">3. Legal Information</a></h2>

<h3><a name="_Toc188970663">A. Data Controllers &amp; Data Protection Officers</a></h3>

<p>AIMSwasthya is the sole controller of the data processed when you use its services. For any concerns or questions regarding the processing of your personal data or to exercise your data protection rights, you may contact AIMSwasthya&rsquo;s Data Protection Officer. You can reach the Data Protection Officer via email at dpo@aimswasthya.com or by mail at [.].</p>

<p>Our Data Protection Officer is dedicated to addressing data privacy concerns and ensuring compliance with applicable privacy laws.</p>

<h3><a name="_Toc188970664">B. Grievance Redressal Mechanism</a></h3>

<p>In accordance with the Information Technology (Intermediary Guidelines and Digital Media Ethics Code) Rules, 2021, AIMSwasthya has appointed a Grievance Officer to address user complaints and resolve any issues related to the use of our services.</p>

<p><strong>Grievance Officer Details:</strong><br />
Name: [Name of the Grievance Officer]<br />
Designation: Grievance Officer<br />
Email: grievanceofficer@aimswasthya.com<br />
Contact Address: [Full Address of AIMSwasthya Office]<br />
Phone: [Grievance Officer&#39;s Contact Number]</p>

<p>Grievance Redressal Process:</p>

<ol>
	<li>Users may raise complaints or concerns regarding any aspect of our services by contacting the Grievance Officer through the email address provided above.</li>
	<li>Complaints will be acknowledged within 24 hours of receipt.</li>
	<li>AIMSwasthya aims to resolve all grievances within 15 days from the date of receipt.</li>
	<li>For unresolved matters or escalations, the Grievance Officer may coordinate with relevant teams to ensure prompt and satisfactory resolution.</li>
</ol>

<p>We are committed to addressing your concerns effectively and in compliance with applicable laws and regulations.</p>

<h3><a name="_Toc188970665">C. Updates to this Privacy Policy</a></h3>

<p>We may update this Privacy Policy from time to time. If we make significant changes, we will notify you in advance through the AIMSwasthya app, email, or other appropriate means. We encourage you to review this Privacy Policy periodically to stay informed about our privacy practices.</p>

<p>Your continued use of AIMSwasthya&rsquo;s services following an update constitutes your acknowledgment and acceptance of the updated Privacy Policy, to the extent permitted by applicable law.</p>
""";

  final termsOfUse = """
<h1><strong>Terms of Usage</strong></h1>

<p><strong>&nbsp;</strong></p>

<p><strong>Infinilex Ventures Private Limited, a private limited liability company established in India with CIN [.], having its registered office at [.], on behalf of itself and its affiliates/group companies under the brand &quot;AIMSwasthya&quot; (&ldquo;AIMSwasthya&rdquo;), is the author and publisher of the internet resource<a href="http://www.aimswasthya.in/"> www.aimswasthya.in</a> and the mobile application &lsquo;AIMSwasthya&rsquo; (together, &ldquo;Platform&rdquo;).</strong></p>

<p><strong>PLEASE READ THESE TERMS CAREFULLY BEFORE ACCESSING OR USING THE SERVICES. Your access and use of the Services constitute your agreement to be bound by these Terms, which establishes a contractual relationship between you and AIMSwasthya.</strong></p>

<p><strong>&nbsp;</strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133529">Terms of Usage. 1</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133530">1. Nature and Applicability of Terms. 2</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133531">2. Conditions Of Use. 4</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133532">3. Terms of Use for End Users other than Practitioners. 4</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133533">3.1 &nbsp; End-User Account and Data Privacy. 4</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133534">3.2 &nbsp; Relevance Algorithm &amp; AI-based performance. 6</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133535">3.3 &nbsp; Listing Content &amp; Disseminating Information. 7</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133536">3.4 Appointment Booking. 8</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133537">3.5 &nbsp; No Doctor-Patient Relationship, Not for Emergency Use. 10</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133538">3.6 Doctor&rsquo;s Consultation. 11</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133539">3.7 Keeping You Healthy Feed. 13</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133540">3.8 Content Ownership and Copyright Conditions of Access. 13</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133541">3.9 Patient Reviews. 14</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133542">3.10 Records. 15</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133543">4. Terms for Practitioners. 18</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133544">4.1 Listing Policy. 18</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133545">4.2 Profile Ownership &amp; Editing Rights. 18</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133546">4.3 Patient Review Display Rights of AIMSwasthya. 19</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133547">4.4 Relevance Algorithm.. 20</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133548">4.5 Independent Services. 20</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133549">4.6 Aimswasthya Reach Rights. 20</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133550">4.7 Practitioner Qualifications &amp; Compliance. 20</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133551">4.8 Usage In Promotional &amp; Marketing Materials. 21</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133552">5. Rights &amp; Ownership related to Content 21</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133553">6. Termination. 23</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133554">7. Limitation of Liability. 24</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133555">8. Retention and Removal 24</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133556">9. Applicable Law and Dispute Resolution. 25</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133557">9.1 Governing Law.. 25</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133558">9.2 Arbitration. 25</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133559">10. Data Protection Officer &amp; Grievance Officer 25</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133560">10.1 Data Protection Officer 25</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133561">10.2 Grievance Officer 26</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133562">11. Severability. 26</a></strong></p>

<p><strong><a href="https://d.docs.live.net/f86d3979f9573156/Desktop/AimSwasthya/Terms%20of%20Usage.docx#_Toc189133563">12. Waiver 27</a></strong></p>

<p><strong>&nbsp;</strong></p>

<p><strong>&nbsp;</strong></p>

<h2><strong>1. Nature and Applicability of Terms</strong></h2>

<p><strong>Please carefully read these terms and conditions (&ldquo;Terms&rdquo;) and the Privacy Policy available at www.aimswasthya.in/privacy-policy (&ldquo;Privacy Policy&rdquo;) before accessing the Platform or availing the services made available by AIMSwasthya. These Terms and the Privacy Policy together constitute a legal agreement (&ldquo;Agreement&rdquo;) between you and Infinilex Ventures Private Limited (&ldquo;AIMSwasthya,&rdquo; &ldquo;we,&rdquo; &ldquo;us,&rdquo; or &ldquo;our&rdquo;) in connection with your visit to the Platform and your use of the Services (as defined below).</strong></p>

<p><strong>This Agreement applies to you whether you are:</strong></p>

<ul>
	<li>
	<p><strong>A medical practitioner, healthcare provider (whether an individual professional or an organization), or similar institution wishing to be listed, or already listed, on the Platform, including designated, authorized associates of such practitioners or institutions (&ldquo;Practitioner(s),&rdquo; &ldquo;you,&rdquo; or &ldquo;User&rdquo;); or</strong></p>
	</li>
	<li>
	<p><strong>An end-user, patient, representative, or affiliate searching for Practitioners through the Platform (&ldquo;End-User,&rdquo; &ldquo;you,&rdquo; or &ldquo;User&rdquo;); or</strong></p>
	</li>
	<li>
	<p><strong>Any other individual or entity accessing the Platform (&ldquo;you&rdquo; or &ldquo;User&rdquo;).</strong></p>
	</li>
</ul>

<p><strong>This Agreement applies to services made available by AIMSwasthya on the Platform (&ldquo;Services&rdquo;), which include, but are not limited to, the following:</strong></p>

<ul>
	<li>
	<p><strong>For Practitioners: Listing of Practitioners along with their profiles and contact details to be accessible to Users and visitors of the Platform.</strong></p>
	</li>
	<li>
	<p><strong>For End-Users: Facilities to (i) create and maintain Health Accounts, (ii) search for Practitioners by name, specialty, or location, and (iii) receive recommendations of specialists based on symptoms entered through our AI-powered system.</strong></p>
	</li>
</ul>

<p><strong>The Services may evolve and change from time to time, at the sole discretion of AIMSwasthya. This Agreement applies to your visit to and use of the Platform to avail of the Services, as well as to all information you provide on the Platform at any time.</strong></p>

<p><strong>This Agreement sets out the terms and conditions under which you may use the Platform and outlines how we will manage your account while you are registered with us. If you have any questions regarding this Agreement, feel free to contact us at support@aimswasthya.in.</strong></p>

<p><strong>By downloading, accessing, or using the Platform to avail of the Services, you irrevocably accept all the conditions stipulated in this Agreement and the Privacy Policy and agree to be bound by them. This Agreement supersedes any previous terms communicated to you concerning your use of the Platform to access the Services. Your continued use of any Service constitutes your acceptance of the terms of this Agreement.</strong></p>

<p><strong>We reserve the right to modify, amend, or terminate any portion of this Agreement for any reason and at any time. Any significant modifications will be communicated to you through appropriate means, such as email or notifications on the Platform. It is your responsibility to review this Agreement periodically. Your continued use of the Platform following such modifications signifies your acceptance of the changes.</strong></p>

<p><strong>You acknowledge that you are bound by this Agreement whenever you use the Services provided by us. If you disagree with any part of the Agreement, please refrain from using the Platform or availing of any Services.</strong></p>

<p><strong>Your access to and use of the Platform and Services will be solely at AIMSwasthya&rsquo;s discretion.</strong></p>

<p><strong>This Agreement is governed by and published in compliance with Indian law, including, but not limited to:</strong></p>

<ul>
	<li>
	<p><strong>The Indian Contract Act, 1872,</strong></p>
	</li>
	<li>
	<p><strong>The (Indian) Information Technology Act, 2000,</strong></p>
	</li>
	<li>
	<p><strong>The rules, regulations, guidelines, and clarifications under the Information Technology (Reasonable Security Practices and Procedures and Sensitive Personal Information) Rules, 2011 (&ldquo;SPI Rules&rdquo;), and the Information Technology (Intermediary Guidelines and Digital Media Ethics Code) Rules, 2021 (&ldquo;IG Rules&rdquo;), and,</strong></p>
	</li>
	<li>
	<p><strong>Digital Personal Data Protection Act, 2023.</strong></p>
	</li>
</ul>

<h2><strong>2. Conditions Of Use</strong></h2>

<p><strong>You must be 18 years of age or older to register, use the Services, or visit or use the Website in any manner. By registering, visiting and using the Website or accepting this Agreement, you represent and warrant to AIMSwasthya that you are 18 years of age or older, and that you have the right, authority and capacity to use the Website and the Services available through the Website, and agree to and abide by this Agreement.</strong></p>

<h2><strong>3. Terms of Use for End Users other than Practitioners</strong></h2>

<h3><strong>3.1&nbsp; End-User Account and Data Privacy</strong></h3>

<p><strong>3.1.1 The terms &ldquo;personal information&rdquo; and &ldquo;sensitive personal data or information&rdquo; are defined under the SPI Rules and are detailed in the Privacy Policy.</strong></p>

<p><strong>3.1.2 AIMSwasthya, through its Services, may collect information about the devices you use to access the Platform and anonymous usage data. This information will be used solely to improve the quality of AIMSwasthya&rsquo;s services and to develop new features and services.</strong></p>

<p><strong>3.1.3 The Platform enables AIMSwasthya to access registered Users&rsquo; personal email addresses and/or phone numbers for communication purposes, such as facilitating better appointment bookings and gathering feedback regarding Practitioners and their practices.</strong></p>

<p><strong>3.1.4 The Privacy Policy sets out, among other things:</strong></p>

<p><strong>&middot;&nbsp; &nbsp; &nbsp; &nbsp; The types of information collected from Users, including sensitive personal data or information;</strong></p>

<p><strong>&middot;&nbsp; &nbsp; &nbsp; &nbsp; The purpose, means, and modes of collecting and using such information;</strong></p>

<p><strong>&middot;&nbsp; &nbsp; &nbsp; &nbsp; How and to whom AIMSwasthya will disclose such information; and</strong></p>

<p><strong>&middot;&nbsp; &nbsp; &nbsp; &nbsp; Other details required under the SPI Rules.</strong></p>

<p><strong>3.1.5 Users are expected to read and understand the Privacy Policy to ensure awareness regarding, among other things:</strong></p>

<p><strong>&middot;&nbsp; &nbsp; &nbsp; &nbsp; The fact that certain information is being collected;</strong></p>

<p><strong>&middot;&nbsp; &nbsp; &nbsp; &nbsp; The purpose for which the information is being collected;</strong></p>

<p><strong>&middot;&nbsp; &nbsp; &nbsp; &nbsp; The intended recipients of the information;</strong></p>

<p><strong>&middot;&nbsp; &nbsp; &nbsp; &nbsp; The method of collection and retention of the information;</strong></p>

<p><strong>&middot;&nbsp; &nbsp; &nbsp; &nbsp; The name and address of the agency collecting and retaining the information; and</strong></p>

<p><strong>&middot;&nbsp; &nbsp; &nbsp; &nbsp; The various rights available to Users concerning their information.</strong></p>

<p><strong>3.1.6 AIMSwasthya is not responsible for the authenticity of the personal information or sensitive personal data or information provided by the User to AIMSwasthya or any other party acting on behalf of AIMSwasthya.</strong></p>

<p><strong>3.1.7 Users are responsible for maintaining the confidentiality of their account access information and password if registered on the Platform. Users will be held accountable for all activities carried out using their account credentials, whether authorized or unauthorized. Users must immediately notify AIMSwasthya of any unauthorized use or security breach of their account. Although AIMSwasthya will not be liable for any losses incurred by Users due to unauthorized use, Users may be held liable for any losses suffered by AIMSwasthya or other parties due to such unauthorized use.</strong></p>

<p><strong>3.1.8 If any information provided by a User is found to be untrue, inaccurate, outdated, or incomplete (or becomes so), or if AIMSwasthya has reasonable grounds to suspect such information, AIMSwasthya reserves the right to discontinue the Services for that User at its sole discretion.</strong></p>

<p><strong>3.1.9 AIMSwasthya may use information collected from Users to debug and address customer support issues from time to time.</strong></p>

<p><strong>3.1.10 AIMSwasthya may provide a &lsquo;Show Contact&rsquo; feature against each Practitioner profile, allowing Users to contact Practitioners through an intermediary telephony service. Calls made using this feature may be recorded and stored on AIMSwasthya&rsquo;s servers. These recordings will be processed in accordance with the Privacy Policy and may be used for quality control and support-related purposes.</strong></p>

<p><strong>An IVR message will inform Users of the purpose of call recording and request their consent. By proceeding with the call, Users consent to such recordings. These facilities are strictly for appointment booking purposes and must not be used for health consultations. AIMSwasthya is not liable for any misuse of this facility.</strong></p>

<p><strong>If a User does not consent to the recording of calls containing personal information required for appointment or booking purposes, AIMSwasthya reserves the right to withhold Services requiring such information.</strong></p>

<p><strong>&nbsp;</strong></p>

<h3><strong>3.2&nbsp; Relevance Algorithm &amp; AI-based performance</strong></h3>

<p><strong>AIMSwasthya&rsquo;s relevance algorithm for Practitioners is a fully automated system that displays Practitioner profiles and information about their practice on the Platform. These Practitioner listings do not constitute a fixed ranking or endorsement by AIMSwasthya.</strong></p>

<p><strong>Additionally, AIMSwasthya uses advanced AI-based technology to analyze the symptoms entered by Users and provide potential diagnostic insights and specialist recommendations. The AI system evaluates User inputs based on established medical data and algorithms to deliver tailored suggestions. However, these recommendations are for informational purposes only and do not substitute professional medical advice, diagnosis, or treatment.</strong></p>

<p><strong>AIMSwasthya shall not be held liable for:</strong></p>

<ol>
	<li>
	<p><strong>Any changes in the relevance or order of Practitioners in search results, which may vary over time due to updates in the algorithm.</strong></p>
	</li>
	<li>
	<p><strong>The accuracy, relevance, or appropriateness of AI-based recommendations provided through the Platform. Users are strongly advised to consult a licensed medical practitioner for definitive diagnosis or treatment.</strong></p>
	</li>
</ol>

<p><strong>The listing of Practitioners is determined through automated calculations based on various factors, including User inputs such as feedback and comments. These factors, along with the AI algorithms, may be updated periodically to enhance the functionality and accuracy of the Platform.</strong></p>

<p><strong>AIMSwasthya makes no guarantees regarding the accuracy or relevance of the Practitioner listing order or the AI-generated recommendations on the Platform and assumes no liability for any reliance placed on such outputs.</strong></p>

<h3><strong>3.3&nbsp; Listing Content &amp; Disseminating Information</strong></h3>

<p><strong>3.3.1 Practitioner Information: AIMSwasthya collects, directly or indirectly, and displays relevant information about the profiles and practices of the Practitioners listed on the Platform, such as their specialization, qualifications, fees, location, visiting hours, and other similar details. AIMSwasthya takes reasonable efforts to ensure that such information is updated at regular intervals. Although AIMSwasthya screens and vets the information and photos submitted by Practitioners, it cannot be held liable for any inaccuracies or incompleteness despite such reasonable efforts.</strong></p>

<p><strong>&nbsp;</strong></p>

<p><strong>3.3.2 Limitation of Liability: The Services provided by AIMSwasthya or any of its licensors or service providers are provided on an &quot;as is&quot; and &quot;as available&quot; basis, without any warranties or conditions (express or implied), including but not limited to the implied warranties of merchantability, accuracy, fitness for a particular purpose, title, and non-infringement, arising by statute, law, or from the course of dealings, usage, or trade. AIMSwasthya does not guarantee the accuracy, completeness, or availability of any content or information provided by Users on the Platform. To the fullest extent permitted by law, AIMSwasthya disclaims all liability arising from your use or reliance upon the Platform, the Services, representations or warranties made by other Users, content provided by Users, or any opinions or suggestions made by AIMSwasthya or Users regarding any services offered by Practitioners.</strong></p>

<p><strong>&nbsp;</strong></p>

<p><strong>3.3.3 Third-Party Links: The Platform may contain links to third-party websites, affiliates, and business partners. AIMSwasthya does not have control over, and is not responsible or liable for the content, accuracy, reliability, quality, or availability of such third-party websites or services made available by or through the Platform. The inclusion of any link does not imply endorsement by AIMSwasthya. Users may use these links and services at their own risk.</strong></p>

<p><strong>&nbsp;</strong></p>

<p><strong>3.3.4 Platform Security and User Risks: AIMSwasthya assumes no responsibility, and shall not be liable for, any damages to or viruses that may infect a User&rsquo;s equipment due to access, use, or browsing of the Platform, or the downloading of any material, data, text, images, video content, or audio content from the Platform. If a User is dissatisfied with the Platform, the sole remedy is to discontinue using it.</strong></p>

<p><strong>&nbsp;</strong></p>

<p><strong>3.3.5 Fraudulent or Inaccurate Information: If AIMSwasthya determines that a User has provided fraudulent, inaccurate, or incomplete information (including through feedback), AIMSwasthya reserves the right to immediately suspend access to the Platform or any of the User&rsquo;s accounts. In such cases, AIMSwasthya may display a declaration on the Platform alongside the User&rsquo;s name or clinic&rsquo;s name to protect the business and safeguard the interests of other Users. The User shall indemnify AIMSwasthya for any losses incurred due to misrepresentations or fraudulent feedback adversely affecting AIMSwasthya or other Users.</strong></p>

<h3><strong>3.4 Appointment Booking</strong></h3>

<p><strong>AIMSwasthya enables Users to connect with Practitioners through the Book Appointment facility, allowing Users to schedule appointments through the Platform.</strong></p>

<p><strong>3.4.1 Appointment Confirmation</strong></p>

<p><strong>AIMSwasthya will ensure Users are provided with confirmed appointments via the Book Appointment facility. However, AIMSwasthya is not liable if such an appointment is later canceled by the Practitioner or the same Practitioner is unavailable for the appointment.</strong></p>

<p><strong>3.4.2 No Healthcare Responsibility</strong></p>

<p><strong>AIMSwasthya is not responsible for any interactions between the User and the Practitioner. Users understand and agree that AIMSwasthya will not be liable for:</strong></p>

<ul>
	<li>
	<p><strong>Any issues or interactions the User has with the Practitioner;</strong></p>
	</li>
	<li>
	<p><strong>The ability or intent of the Practitioner(s) to fulfill their obligations to the User;</strong></p>
	</li>
	<li>
	<p><strong>Any incorrect medication, substandard treatment, or medical negligence by the Practitioner(s);</strong></p>
	</li>
	<li>
	<p><strong>Inappropriate treatment or inconvenience suffered by the User due to the Practitioner&rsquo;s failure to provide the agreed services;</strong></p>
	</li>
	<li>
	<p><strong>Any misconduct or inappropriate behavior by the Practitioner or their staff;</strong></p>
	</li>
	<li>
	<p><strong>Cancellations, no-shows, rescheduled appointments, or variations in fees charged by the Practitioner, unless addressed under the AIMSwasthya Guarantee Program.</strong></p>
	</li>
</ul>

<p><strong>3.4.3 Practitioner Listings</strong></p>

<p><strong>The results of any search performed by the User for Practitioners on the Platform should not be construed as an endorsement by AIMSwasthya of any particular Practitioner. If the User decides to engage with a Practitioner to seek medical services, it will be done at their own risk.</strong></p>

<p><strong>3.4.4 User Feedback</strong></p>

<p><strong>Users are allowed to provide feedback about their experiences with the Practitioner. However, the User shall ensure that such feedback complies with applicable laws. Users understand that AIMSwasthya is not obligated to act on the content of the feedback, such as requests for delisting a Practitioner from the Platform.</strong></p>

<p><strong>3.4.5 Patient-No-Show (P.N.S.) Policy</strong></p>

<p><strong>In case of a Patient-No-Show (P.N.S.), where the User does not show up for the scheduled appointment with the Practitioner:</strong></p>

<ul>
	<li>
	<p><strong>The User&rsquo;s account may be temporarily disabled from booking further online appointments for the next four (4) months after three (3) valid PNS occurrences, as per the PNS Policy.</strong></p>
	</li>
	<li>
	<p><strong>For the purposes of this clause, a Patient-No-Show (P.N.S.) is defined as any instance where the User does not show up for a scheduled appointment without informing the Practitioner or canceling/rescheduling it in advance. The Practitioner must notify AIMSwasthya of the P.N.S. incident within five (5) days of the scheduled appointment. AIMSwasthya will then send an email and SMS (&quot;PNS Communication&quot;) to confirm the incident and request an explanation from the User.</strong></p>
	</li>
	<li>
	<p><strong>If the User does not respond within seven (7) days or provides unacceptable reasons (e.g., forgetting the appointment, choosing another Practitioner), the User will be penalized as per this clause.</strong></p>
	</li>
	<li>
	<p><strong>If a User is unable to attend due to valid reasons such as sickness, and after investigation by AIMSwasthya, the User may receive a refund, less any applicable cancellation charges.</strong></p>
	</li>
</ul>

<p><strong>3.4.6 Cancellation and Refund Policy</strong></p>

<p><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i.&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; If the Practitioner with whom the User booked a paid appointment via the Platform is unavailable or unable to meet the User, the User must contact AIMSwasthya at support@aimswasthya.in within five (5) days. AIMSwasthya will refund the entire consultation fee within five (5) to six (6) business days in the original mode of payment.</strong></p>

<p><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ii.&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; If the User does not show up for the appointment without canceling it in advance, no refund will be issued, and it will be treated under the P.N.S. Policy. If cancellation charges are levied by the Practitioner, the User is not entitled to a full refund, even if the appointment was canceled in advance.</strong></p>

<p><strong>&nbsp;&nbsp;&nbsp;iii.&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Users will not be entitled to refunds if the Practitioner is late but the User chooses to wait or decides not to proceed with the consultation.</strong></p>

<p><strong>&nbsp;&nbsp;&nbsp;iv.&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Users are allowed a period of three (3) days to flag any consultation as inadequate, and request for a refund. No refund requests shall be considered thereafter. AIMSwasthya&nbsp; shall check the details and process the refund where applicable, solely at its discretion. After a refund request is processed, the money will be refunded to the User in seven (7) working days from the day refund has been approved by AIMSwasthya.</strong></p>

<p><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;v.&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; In all matters related to refund and settlement under this Agreement, AIMSwasthya shall decide so at its sole and absolute discretion after detailed review of the matter and taking into account all the involved parties&rsquo; information. The decision of AIMSwasthya shall be final in this regard.</strong></p>

<p><strong>&nbsp;</strong></p>

<h3><strong>3.5&nbsp; No Doctor-Patient Relationship, Not for Emergency Use</strong></h3>

<p><strong>3.5.1 Some of the content, text, data, graphics, images, information, suggestions, guidance, and other material (collectively, &ldquo;Information&rdquo;) available on the AIMswasthya platform, including responses to user queries, may be generated through AI-based analysis of symptoms or provided by medical professionals. However, this does not create a doctor-patient relationship between AIMswasthya and the user, nor does it constitute a medical opinion, diagnosis, or treatment. The Information is intended solely to assist users in identifying potential health concerns and locating appropriate medical professionals.</strong></p>

<p><strong>3.5.2 The Information provided by AIMswasthya, its AI system, employees, contractors, partners, advertisers, licensors, or any third parties is for informational purposes only. AIMswasthya does not guarantee the accuracy, reliability, or completeness of such Information and does not make any warranties, express or implied, regarding the qualifications, expertise, or competency of any recommended medical professional. Users are advised to exercise their own judgment and consult a licensed healthcare provider before making any medical decisions. AIMswasthya shall not be liable for any actions taken by users based on the Information available on the platform.</strong></p>

<p><strong>3.5.3 AIMswasthya is not intended to be a substitute for professional medical advice, diagnosis, or emergency care. If you are experiencing a medical emergency, you should immediately contact emergency services, visit a hospital, or consult a qualified healthcare provider. The platform does not provide emergency medical assistance or real-time health interventions.</strong></p>

<h3><strong>3.6 Doctor&rsquo;s Consultation</strong></h3>

<p><strong>3.6.1 AIMswasthya is a technology platform that assists users in identifying and connecting with relevant medical specialists based on their symptoms. The platform provides recommendations through its AI-based algorithm, and in some cases, users may choose a specialist from the available list. However, AIMswasthya does not provide medical consultations, diagnoses, prescriptions, or emergency healthcare services.</strong></p>

<p><strong>3.6.2 Users acknowledge that AIMswasthya only facilitates offline consultations by helping them find suitable healthcare providers. All medical advice, diagnoses, and treatments are solely the responsibility of the respective practitioners consulted offline. AIMswasthya does not influence or guarantee the accuracy, quality, or effectiveness of any medical advice or treatment received.</strong></p>

<p><strong>3.6.3 Users agree that AIMswasthya is not a substitute for emergency medical care. If users require urgent or life-threatening medical attention, they must directly contact a hospital, ambulance service, or emergency healthcare provider.</strong></p>

<p><strong>3.6.4 Users understand and accept that AIMswasthya does not:</strong></p>

<ul>
	<li>
	<p><strong>Conduct or facilitate medical consultations on its platform.</strong></p>
	</li>
	<li>
	<p><strong>Issue or assist in obtaining medical prescriptions.</strong></p>
	</li>
	<li>
	<p><strong>Guarantee the availability, suitability, or expertise of any healthcare provider.</strong></p>
	</li>
	<li>
	<p><strong>Assume liability for medical advice, treatment outcomes, or any negligence by the practitioners.</strong></p>
	</li>
</ul>

<p><strong>3.6.5 Users shall ensure that all decisions regarding their health, including choosing a practitioner, seeking treatment, and following medical advice, are made at their own discretion and responsibility. AIMswasthya does not verify or endorse any specific medical recommendations.</strong></p>

<p><strong>3.6.6 Users shall provide accurate and complete health-related information when consulting practitioners offline. AIMswasthya shall not be responsible for any consequences arising from misrepresentation, omission, or failure to disclose relevant health details.</strong></p>

<p><strong>3.6.7 AIMswasthya reserves the right to conduct audits or collect feedback regarding user experiences with listed practitioners. However, such audits are for quality improvement purposes only and do not constitute medical oversight or validation of practitioners&#39; credentials.</strong></p>

<p><strong>3.6.8 Users shall not:</strong></p>

<ul>
	<li>
	<p><strong>Seek medical advice or diagnoses through AIMswasthya&rsquo;s platform.</strong></p>
	</li>
	<li>
	<p><strong>Request prescriptions, reports, or medical opinions from the platform.</strong></p>
	</li>
	<li>
	<p><strong>Use the platform for purposes unrelated to locating medical practitioners.</strong></p>
	</li>
	<li>
	<p><strong>Engage in abusive, offensive, or inappropriate behavior when interacting with AIMswasthya&rsquo;s support team or listed practitioners. AIMswasthya reserves the right to deny access to users violating these terms.</strong></p>
	</li>
</ul>

<p><strong>3.6.9 Users understand that AIMswasthya does not determine consultation fees, availability, or appointment terms set by practitioners. All financial transactions related to medical services are directly between the user and the respective practitioner. AIMswasthya shall not be liable for any disputes, cancellations, or refunds regarding offline consultations.</strong></p>

<p><strong>3.6.10 Users acknowledge that AIMswasthya operates under Indian laws and regulations. Any claims, disputes, or legal matters related to its services shall be subject to the jurisdiction provisions outlined in these Terms of Usage.</strong></p>

<p><strong>3.6.11 Users agree to indemnify and hold harmless AIMswasthya, its affiliates, officers, employees, and agents from any claims, damages, legal liabilities, or expenses arising due to:</strong></p>

<ul>
	<li>
	<p><strong>Misuse of the platform.</strong></p>
	</li>
	<li>
	<p><strong>Violation of these Terms of Usage.</strong></p>
	</li>
	<li>
	<p><strong>Any medical malpractice or negligence by the practitioners consulted offline.</strong></p>
	</li>
</ul>

<p><strong>3.6.12 Users may make payments for practitioner appointments via AIMswasthya&rsquo;s payment gateway. AIMswasthya is not responsible for payment failures, processing delays, or disputes related to fees charged by practitioners.</strong></p>

<h3><strong>3.7 Keeping You Healthy Feed</strong></h3>

<p><strong>3.7.1 AIMswasthya provides health-related blogs, articles, and informational content under its &quot;Keeping You Healthy&quot; section. This content is for informational purposes only and should not be considered medical advice, diagnosis, or treatment. Users are encouraged to consult a qualified healthcare professional before making any health-related decisions based on the information provided in these blogs. AIMswasthya does not warrant the accuracy, completeness, or applicability of any information published in this section.</strong></p>

<p><strong>3.7.2 AIMSwasthya shall have the right to edit or remove the Content and any comments in such manner as it may deem AIMSwasthya Keeping You Healthy feed at any time.</strong></p>

<p><strong>3.7.3 The User agrees to absolve AIMSwasthya from and indemnify AIMSwasthya against all claims that may arise as a result of the User&rsquo;s actions resulting from the User&rsquo;s viewing of Content on AIMSwasthya Keeping You Healthy feed.</strong></p>

<p><strong>3.7.4 The User acknowledges that all intellectual property rights in any content, shall vest exclusively with AIMSwasthya. The User agrees not to infringe upon AIMSwasthya&rsquo;s intellectual property by copying, plagiarizing, or republishing content from the Keeping You Healthy feed without explicit written permission from AIMSwasthya. Any unauthorized use of the content may result in legal action.</strong></p>

<h3><strong>3.8 Content Ownership and Copyright Conditions of Access</strong></h3>

<p><strong>3.8.1 The content available on the AIMSwasthya Website, including but not limited to:</strong></p>

<ul>
	<li>
	<p><strong>User-generated content, and</strong></p>
	</li>
	<li>
	<p><strong>Content owned by AIMSwasthya,</strong></p>
	</li>
</ul>

<p><strong>shall remain the sole property of AIMSwasthya. Any information collected directly or indirectly from Users, Practitioners, or other sources shall also belong exclusively to AIMSwasthya. Copying, reproducing, or using any copyrighted content published on the Website for commercial purposes or financial gain without explicit authorization from AIMSwasthya shall constitute a violation of copyright laws, and AIMSwasthya reserves its legal rights accordingly.</strong></p>

<p><strong>3.8.2 AIMSwasthya grants Users a limited, non-exclusive, non-transferable right to view and access the content on the Website solely for the purpose of using its services in accordance with this Agreement. The content on the Website, including but not limited to text, graphics, images, logos, button icons, software code, design, arrangement, and assembly of content (collectively, &quot;AIMSwasthya Content&quot;), is the exclusive property of AIMSwasthya and is protected under copyright, trademark, and other applicable intellectual property laws. Users shall not modify, reproduce, display, publicly perform, distribute, or otherwise use the AIMSwasthya Content for any public, commercial, or personal gain without prior written permission from AIMSwasthya.</strong></p>

<p><strong>3.8.3 Users shall not access or attempt to access AIMSwasthya&#39;s services for the purposes of:</strong></p>

<ul>
	<li>
	<p><strong>Monitoring availability, performance, or functionality,</strong></p>
	</li>
	<li>
	<p><strong>Benchmarking, or</strong></p>
	</li>
	<li>
	<p><strong>Any competitive analysis.</strong></p>
	</li>
</ul>

<p><strong>Any such unauthorized use shall be deemed a violation of this Agreement, and AIMSwasthya reserves its right to take appropriate legal action.</strong></p>

<h3><strong>3.9 Patient Reviews</strong></h3>

<p><strong>3.9.1 By using the AIMSwasthya Website, you agree that any information you share with AIMSwasthya or with any Practitioner will be subject to our Privacy Policy. You are solely responsible for the content you choose to submit for publication on the Website, including any patient stories, reviews or testimonials (&quot;Critical Content&quot;) related to Practitioners or healthcare professionals.</strong></p>

<p><strong>3.9.2 The role of AIMSwasthya in publishing Critical Content is restricted to that of an &lsquo;intermediary&rsquo; under applicable law. AIMSwasthya disclaims all responsibility concerning the content of the Critical Content. Our role is confined to fulfilling obligations as an &lsquo;intermediary&rsquo; and AIMSwasthya will not be held liable for any claims regarding the content submitted. Additionally, AIMSwasthya is not obligated to pay any User for re-publishing any content across its platforms.</strong></p>

<p><strong>3.9.3 Your publication of patient reviews and/or stories on the Website is governed by Clause 5 of these Terms. Without prejudice to the detailed terms in Clause 5, you agree not to post or publish any content on the Website that:</strong></p>

<ul>
	<li>
	<p><strong>Infringes upon any third-party intellectual property, publicity, or privacy rights, or</strong></p>
	</li>
	<li>
	<p><strong>Violates any applicable law or regulation, including but not limited to IG Rules and SPI Rules.</strong></p>
	</li>
</ul>

<p><strong>3.9.4 At its sole discretion, AIMSwasthya may choose not to publish your patient reviews and/or stories if required by applicable law and in accordance with Clause 5 of these Terms.</strong></p>

<p><strong>You agree that AIMSwasthya may contact you through telephone, email, SMS, or other electronic means for the following purposes:</strong></p>

<ul>
	<li>
	<p><strong>Obtaining feedback about the Website or AIMSwasthya&rsquo;s services;</strong></p>
	</li>
	<li>
	<p><strong>Obtaining feedback about any Practitioners listed on the Website;</strong></p>
	</li>
	<li>
	<p><strong>Resolving any complaints, queries, or issues raised by Practitioners concerning your Critical Content.</strong></p>
	</li>
</ul>

<p><strong>You agree to fully cooperate with AIMSwasthya in such communications. Our Feedback Collection and Fraud Detection Policy is annexed as the Schedule hereto and remains subject to these Terms.</strong></p>

<h3><strong>3.10 Records</strong></h3>

<p><strong>AIMSwasthya may provide End-Users with a feature known as &lsquo;Health Records&rsquo; on its platform. The information available in your Health Records will consist of the information uploaded by you or generated during your interaction with the AIMSwasthya platform, e.g., appointment details, medical prescriptions, or treatments.</strong></p>

<p><strong>The specific terms relating to such Health Records are as follows, without prejudice to the rest of these Terms and the Privacy Policy:</strong></p>

<p><strong>3.10.1 Creation of Health Records</strong></p>

<p><strong>Your Health Records will only be created after you have signed up and explicitly accepted these Terms.</strong></p>

<p><strong>3.10.2 User-Created Health Records</strong></p>

<p><strong>All Health Records are created based on the information you upload or input while interacting with the AIMSwasthya platform. This includes appointment details, medical prescriptions, or treatments, and does not include any health records stored or maintained by your Practitioner.</strong></p>

<p><strong>3.10.3 Availability of Health Records</strong></p>

<p><strong>While AIMSwasthya provides a platform to manage your Health Records, we do not guarantee the availability or accuracy of records stored outside the AIMSwasthya ecosystem, including records of the Practitioner who you have consulted through the platform. You should contact the relevant Practitioner if there are any discrepancies in the Health Records or if you wish to modify or update your records.</strong></p>

<p><strong>3.10.4 Reminders</strong></p>

<p><strong>Any reminders provided through the Health Records, appointment reminders, are supplemental and meant to remind you of activities prescribed by your Practitioner. AIMSwasthya is not liable if reminders are not delivered, delivered late, or delivered incorrectly. You can turn off the reminder feature at any time through the AIMSwasthya platform.</strong></p>

<p><strong>3.10.5 Updating Contact Details</strong></p>

<p><strong>It is your responsibility to keep your mobile number and email ID updated in the Health Records. AIMSwasthya will send Health Records to the mobile number or email ID associated with your account. If you update your contact information, we will send a confirmation. AIMSwasthya is not liable for any inconvenience caused if you fail to update your contact details.</strong></p>

<p><strong>3.10.6 Security of Health Records</strong></p>

<p><strong>AIMSwasthya uses industry-standard security measures and encryption for your Health Records. However, we cannot guarantee protection from unauthorized access if your login credentials are lost or compromised. You should immediately inform AIMSwasthya of any unauthorized use of your account or credentials. Please safeguard your login details and report any security concerns to support@aimswasthya.in.</strong></p>

<p><strong>3.10.7 Accessing Dependent Health Records</strong></p>

<p><strong>If you access your dependents&rsquo; Health Records, you assume responsibility for those records, as well as all obligations your dependents would have had. You agree that you must obtain prior consent from your dependent before sharing, uploading, or publishing any sensitive personal information. AIMSwasthya is not responsible for any disputes or liabilities arising from the unauthorized use of such dependent data, and you agree to indemnify AIMSwasthya against any related claims or liabilities.</strong></p>

<p><strong>3.10.8 Deleting Health Records</strong></p>

<p><strong>You may request to delete your Health Records by contacting our service support team. However, please note that only your AIMSwasthya account and associated Health Records will be deleted. Health Records stored by your Practitioner will continue to be stored in their respective accounts.</strong></p>

<p><strong>3.10.9 Practitioner Responsibility</strong></p>

<p><strong>AIMSwasthya is not responsible for any content, medical deductions, or language used in your Health Records. Your Practitioner is solely responsible for the accuracy and content of your Health Records.</strong></p>

<p><strong>3.10.10 Compliance with Law</strong></p>

<p><strong>AIMSwasthya will comply with applicable laws in the event that a court or jurisdiction mandates the sharing of Health Records for any reason.</strong></p>

<p><strong>3.10.11 Accessing Health Records</strong></p>

<p><strong>You acknowledge that AIMSwasthya may need to access your Health Records for technical or operational reasons related to the functionality of the service.</strong></p>

<p><strong>3.10.12 Storage of Health Records</strong></p>

<p><strong>You agree that your Health Records will be stored and accessed on the AIMSwasthya platform. The records will be encrypted and visible to you, the end user. Neither AIMSwasthya nor any third-party service will have access to your Health Records. The encryption ensures that only you, the end user, can access and manage your Health Records.</strong></p>

<p><strong>3.10.13 Consent for Health Records Storage</strong></p>

<p><strong>You agree to the storage of your Health Records by the Practitioner or third-party services in accordance with applicable laws. You further agree, upon creating your account with AIMSwasthya, to the mapping of any existing records in the Practitioner&rsquo;s system to your AIMSwasthya user account, should such mapping be required.</strong></p>

<h2><strong>4. Terms for Practitioners</strong></h2>

<h3><strong>4.1 Listing Policy</strong></h3>

<p><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i.&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Every Practitioner on the AIMSwasthya platform must be qualified in the area of expertise that they represent as their qualification.</strong></p>

<p><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ii.&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; AIMSwasthya, directly and indirectly, collects information regarding Practitioners&rsquo; profiles, contact details, and practice details. AIMSwasthya reserves the right to take down any Practitioner&rsquo;s profile as well as the right to display Practitioner profiles, with or without notice to the concerned Practitioner. This information is collected for the purpose of facilitating interactions with End-Users and other Users. If any information displayed on the AIMSwasthya platform in connection with your profile is found to be incorrect, you are required to inform AIMSwasthya immediately to enable the necessary amendments.</strong></p>

<p><strong>&nbsp;&nbsp;&nbsp;iii.&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; AIMSwasthya shall not be liable or responsible for the ranking of Practitioners on external websites and search engines.</strong></p>

<p><strong>&nbsp;&nbsp;&nbsp;iv.&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; AIMSwasthya shall not be responsible or liable in any manner to Users for any losses, damage, injuries, or expenses incurred by Users as a result of any disclosures or publications made by AIMSwasthya, where the User has expressly or implicitly consented to such disclosures or publications. If the User has revoked such consent under the terms of the Privacy Policy, AIMSwasthya shall not be responsible or liable in any manner to the User for any losses, damage, injuries, or expenses incurred due to disclosures made by AIMSwasthya prior to receiving such revocation.</strong></p>

<p><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;v.&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; As a Practitioner, you represent and warrant that you will use the Services in accordance with applicable law. Any contravention of applicable law resulting from your use of these Services is your sole responsibility, and AIMSwasthya accepts no liability for the same.</strong></p>

<h3><strong>4.2 Profile Ownership &amp; Editing Rights</strong></h3>

<p><strong>AIMSwasthya ensures easy access to Practitioners by providing a tool to update their profile information. AIMSwasthya reserves the right of ownership over all Practitioner profiles and photographs and may moderate any changes or updates requested by Practitioners. However, AIMSwasthya retains sole discretion to approve or reject any requests for modifications to profiles. As a Practitioner, you represent and warrant that you are fully entitled under law to upload any content submitted as part of your profile or otherwise while using AIMSwasthya&rsquo;s services. You further warrant that no such content infringes upon any third-party rights, including but not limited to intellectual property rights. If AIMSwasthya becomes aware of a breach of the above representation, it may modify or delete parts of your profile information at its sole discretion, with or without notice to you.</strong></p>

<h3><strong>4.3 Patient Review Display Rights of AIMSwasthya</strong></h3>

<p><strong>4.3.1 All Patient Reviews are content created by the Users of AIMSwasthya (&ldquo;Platform&rdquo;) and the clients of AIMSwasthya customers and Practitioners, including End-Users. AIMSwasthya does not take responsibility for Patient Reviews, and its role with respect to such content is restricted to that of an &lsquo;intermediary&rsquo; under the Information Technology Act, 2000. The role of AIMSwasthya and other legal rights and obligations relating to Patient Reviews are further detailed in Clauses 3.9 and 5 of these Terms.</strong></p>

<p><strong>4.3.2 AIMSwasthya reserves the right to collect feedback and Patient Reviews for all Practitioners, Clinics, and Healthcare Providers listed on the Platform.</strong></p>

<p><strong>4.3.3 AIMSwasthya shall have no obligation to pre-screen, review, flag, filter, modify, refuse, or remove any or all Patient Reviews from any Service, except as required by applicable law.</strong></p>

<p><strong>4.3.4 You understand that by using the Services, you may be exposed to Patient Reviews or other content that you may find offensive or objectionable. AIMSwasthya shall not be liable for any effect on a Practitioner&rsquo;s business due to Patient Reviews of a negative nature. You acknowledge that you are using the Service at your own risk. However, as an &lsquo;intermediary,&rsquo; AIMSwasthya takes steps as required to comply with applicable laws regarding the publication of Patient Reviews. The legal rights and obligations concerning Patient Reviews and any other information sought to be published by Users are further detailed in Clauses 3.9 and 5 of these Terms.</strong></p>

<p><strong>4.3.5 AIMSwasthya will take down information under standards consistent with applicable law and shall in no circumstances be liable or responsible for Patient Reviews, which have been created by Users. The principles set out in relation to third-party content in the Terms of Service for the Platform shall apply mutatis mutandis to Patient Reviews posted on the Platform.</strong></p>

<p><strong>4.3.6 If AIMSwasthya determines that you have provided inaccurate information or enabled fraudulent feedback, AIMSwasthya reserves the right to immediately suspend any of your accounts on the Platform and make such a declaration on the Platform alongside your name/your clinic&#39;s name, as determined by AIMSwasthya, for the protection of its business and in the interests of Users.</strong></p>

<h3><strong>4.4 Relevance Algorithm</strong></h3>

<p><strong>AIMSwasthya has designed its relevance algorithm in the best interest of End-Users and may adjust the relevance algorithm from time to time to improve the quality of results provided to patients. It is a purely merit-driven, proprietary algorithm that cannot be altered for specific Practitioners. AIMSwasthya shall not be liable for any effect on a Practitioner&rsquo;s business interests due to changes in the relevance algorithm.</strong></p>

<p><strong>&nbsp;</strong></p>

<h3><strong>4.5 Independent Services</strong></h3>

<p><strong>Your use of each Service confers upon you only the rights and obligations relating to that specific Service and not to any other service that may be provided by AIMSwasthya.</strong></p>

<h3><strong>4.6 Aimswasthya Reach Rights</strong></h3>

<p><strong>AIMSwasthya reserves the right to display sponsored ads on the Platform. These ads will be marked as &ldquo;Sponsored Ads.&rdquo; Without prejudice to the status of other content, AIMSwasthya will not be liable for the accuracy of information or claims made in Sponsored Ads. AIMSwasthya does not encourage Users to visit Sponsored Ads pages or avail any services from them. AIMSwasthya will not be responsible for the services provided by the advertisers of Sponsored Ads.</strong></p>

<p><strong>You represent and warrant that you will use these Services in accordance with applicable law. Any contravention of applicable law arising from your use of these Services is your sole responsibility, and AIMSwasthya accepts no liability for the same.</strong></p>

<h3><strong>4.7 Practitioner Qualifications &amp; Compliance</strong></h3>

<p><strong>The Practitioner is and shall remain duly registered, licensed, and qualified to practice medicine and/or provide healthcare or wellness services in accordance with applicable laws, regulations, and guidelines set forth by competent authorities. The Practitioner shall not be part of any arrangement that prohibits them from practicing medicine within the territory of India.</strong></p>

<p><strong>The Practitioner shall at all times ensure compliance with all applicable laws governing their practice and shall exercise utmost care in providing consultations and services to End-Users.</strong></p>

<h3><strong>4.8 Usage In Promotional &amp; Marketing Materials</strong></h3>

<p><strong>In recognition of the various offerings and services provided by AIMSwasthya to the Practitioner, the Practitioner shall, subject to their reasonable right to review and approve:</strong></p>

<p><strong>(a) Allow AIMSwasthya to include a brief description of the services provided to the Practitioner in AIMSwasthya&rsquo;s marketing, promotional, and advertising materials.</strong></p>

<p><strong>(b) Allow AIMSwasthya to make reference to the Practitioner in case studies and related marketing materials.</strong></p>

<p><strong>(c) Serve as a reference to AIMSwasthya&rsquo;s existing and potential clients.</strong></p>

<p><strong>(d) Provide video logs, testimonials, e-mailers, banners, interviews to the news media, and provide quotes for press releases.</strong></p>

<p><strong>(e) Make presentations at conferences.</strong></p>

<p><strong>(f) Allow AIMSwasthya to use the Practitioner&rsquo;s name, logo, brand images, taglines, etc., within product literature, e-mailers, press releases, social media, and other advertising, marketing, and promotional materials.</strong></p>

<h2><strong>5. Rights &amp; Ownership related to Content</strong></h2>

<p><strong>5.1 As mandated by Regulation 3(2) of the IG Rules, AIMSwasthya hereby informs Users that they are not permitted to host, display, upload, modify, publish, transmit, update, or share any information that:</strong></p>

<p><strong>&middot; &nbsp; &nbsp; &nbsp; Belongs to another person and to which the User does not have any right.</strong></p>

<p><strong>&middot; &nbsp; &nbsp; &nbsp; Is grossly harmful, harassing, blasphemous, defamatory, obscene, pornographic, pedophilic, libelous, invasive of another&#39;s privacy, hateful, racially or ethnically objectionable, disparaging, or relating to or encouraging money laundering or gambling, or otherwise unlawful in any manner.</strong></p>

<p><strong>&middot; &nbsp; &nbsp; &nbsp; Harms minors in any way.</strong></p>

<p><strong>&middot; &nbsp; &nbsp; &nbsp; Infringes any patent, trademark, copyright, or other proprietary rights.</strong></p>

<p><strong>&middot; &nbsp; &nbsp; &nbsp; Violates any law for the time being in force.</strong></p>

<p><strong>&middot; &nbsp; &nbsp; &nbsp; Deceives or misleads the recipient about the origin of such messages or communicates any information which is grossly offensive or menacing in nature.</strong></p>

<p><strong>&middot; &nbsp; &nbsp; &nbsp; Impersonates another person.</strong></p>

<p><strong>&middot; &nbsp; &nbsp; &nbsp; Contains software viruses or any other computer code, files, or programs designed to interrupt, destroy, or limit the functionality of any computer resource.</strong></p>

<p><strong>&middot; &nbsp; &nbsp; &nbsp; Threatens the unity, integrity, defense, security, or sovereignty of India, friendly relations with foreign states, public order, or causes incitement to the commission of any cognizable offence, prevents investigation of any offence, or is insulting to any other nation.</strong></p>

<p><strong>5.2 Users are also prohibited from:</strong></p>

<p><strong>&nbsp;</strong></p>

<p><strong>&middot; &nbsp; &nbsp; &nbsp; Violating or attempting to violate the integrity or security of the Website or any AIMSwasthya Content.</strong></p>

<p><strong>&middot; &nbsp; &nbsp; &nbsp; Transmitting any information (including job posts, messages, and hyperlinks) on or through the Website that is disruptive or competitive to the provision of Services by AIMSwasthya.</strong></p>

<p><strong>&middot; &nbsp; &nbsp; &nbsp; Intentionally submitting on the Website any incomplete, false, or inaccurate information.</strong></p>

<p><strong>&middot; &nbsp; &nbsp; &nbsp; Making any unsolicited communications to other Users.</strong></p>

<p><strong>&middot; &nbsp; &nbsp; &nbsp; Using any engine, software, tool, agent, or other device or mechanism (such as spiders, robots, avatars, or intelligent agents) to navigate or search the Website.</strong></p>

<p><strong>&middot; &nbsp; &nbsp; &nbsp; Attempting to decipher, decompile, disassemble, or reverse-engineer any part of the Website.</strong></p>

<p><strong>&middot; &nbsp; &nbsp; &nbsp; Copying or duplicating in any manner any of the AIMSwasthya Content or other information available from the Website.</strong></p>

<p><strong>&middot; &nbsp; &nbsp; &nbsp; Framing, hotlinking, or deep-linking any AIMSwasthya Content.</strong></p>

<p><strong>&middot; &nbsp; &nbsp; &nbsp; Circumventing or disabling any digital rights management, usage rules, or other security features of the software.</strong></p>

<p><strong>5.3 AIMSwasthya, upon obtaining knowledge by itself or being brought to actual knowledge by an affected person in writing or through email signed with an electronic signature about any such information as mentioned above, shall be entitled to disable such information that is in contravention of Clauses 5.1 and 5.2. AIMSwasthya shall also be entitled to preserve such information and associated records for at least 90 (ninety) days for production to governmental authorities for investigation purposes.</strong></p>

<p><strong>5.4 In case of non-compliance with any applicable laws, rules, regulations, or the Agreement (including the Privacy Policy) by a User, AIMSwasthya has the right to immediately terminate the access or usage rights of the User to the Website and Services and to remove non-compliant information from the Website.</strong></p>

<p><strong>5.5 AIMSwasthya may disclose or transfer User-generated information to its affiliates or governmental authorities in such manner as permitted or required by applicable law, and you hereby consent to such transfer. The SPI Rules only permit AIMSwasthya to transfer sensitive personal data or information, including any information, to any other body corporate or a person in India or located in any other country that ensures the same level of data protection adhered to by AIMSwasthya as provided under the SPI Rules, only if such transfer is necessary for the performance of a lawful contract between AIMSwasthya or any person on its behalf and the User or where the User has consented to such data transfer.</strong></p>

<p><strong>AIMSwasthya respects the intellectual property rights of others and does not hold any responsibility for violations of any intellectual property rights.</strong></p>

<h2><strong>6. Termination</strong></h2>

<p><strong>6.1 AIMSwasthya reserves the right to suspend or terminate a User&rsquo;s access to the Website and the Services with or without notice and to exercise any other remedy available under law, in cases where:</strong></p>

<ul>
	<li>
	<p><strong>Such User breaches any terms and conditions of the Agreement.</strong></p>
	</li>
	<li>
	<p><strong>A third party reports a violation of any of its rights as a result of the User&rsquo;s use of the Services.</strong></p>
	</li>
	<li>
	<p><strong>AIMSwasthya is unable to verify or authenticate any information provided by the User.</strong></p>
	</li>
	<li>
	<p><strong>AIMSwasthya has reasonable grounds for suspecting any illegal, fraudulent, or abusive activity on the part of such User.</strong></p>
	</li>
	<li>
	<p><strong>AIMSwasthya believes, in its sole discretion, that the User&rsquo;s actions may cause legal liability for the User, other Users, or AIMSwasthya, or are contrary to the interests of the Website.</strong></p>
	</li>
</ul>

<p><strong>6.2 Once temporarily suspended, indefinitely suspended, or terminated, the User may not continue to use the Website under the same account, a different account, or re-register under a new account. Upon termination of an account for the reasons mentioned herein, such User shall no longer have access to data, messages, files, and other material stored on the Website. The User shall ensure that they maintain a continuous backup of any medical services rendered in order to comply with their record-keeping processes and practices.</strong></p>

<h2><strong>7. Limitation of Liability</strong></h2>

<p><strong>7.1 In no event, including but not limited to negligence, shall AIMSwasthya, or any of its directors, officers, employees, agents, content providers, or service providers (collectively, the &ldquo;Protected Entities&rdquo;) be liable for any direct, indirect, special, incidental, consequential, exemplary, or punitive damages arising from, or directly or indirectly related to:</strong></p>

<ul>
	<li>
	<p><strong>The use of, or the inability to use, the Website, the Services, or any content, materials, and functions related thereto.</strong></p>
	</li>
	<li>
	<p><strong>User&rsquo;s provision of information via the Website.</strong></p>
	</li>
	<li>
	<p><strong>Loss of business or loss of End-Users, even if such Protected Entity has been advised of the possibility of such damages.</strong></p>
	</li>
</ul>

<p><strong>7.2 In no event shall the Protected Entities be liable for:</strong></p>

<ul>
	<li>
	<p><strong>The provision of, or failure to provide, any service by Practitioners to End-Users contacted or managed through the Website.</strong></p>
	</li>
	<li>
	<p><strong>Any other matter relating to the Website or the Service.</strong></p>
	</li>
</ul>

<p><strong>7.3 The total aggregate liability of the Protected Entities to a User for all damages, losses, and causes of action (whether in contract or tort, including but not limited to negligence or otherwise) arising from this Agreement or a User&rsquo;s use of the Website or the Services shall not exceed, in aggregate, Rs. 1000/- (Rupees One Thousand Only).</strong></p>

<h2><strong>8. Retention and Removal</strong></h2>

<p><strong>AIMSwasthya may retain information collected from Users on its Website or Services for as long as necessary, depending on the type of information, the purpose, means, and modes of usage of such information, and in accordance with applicable laws, including the SPI Rules. Computer web server logs may be preserved for as long as administratively necessary.</strong></p>

<h2><strong>9. Applicable Law and Dispute Resolution</strong></h2>

<h3><strong>9.1 Governing Law</strong></h3>

<p><strong>This Agreement and any contractual obligation between AIMSwasthya and the User shall be governed by the laws of India.</strong></p>

<h3><strong>9.2 Arbitration</strong></h3>

<p><strong>Any dispute, claim, or controversy arising out of or relating to this Agreement, including the determination of its scope or applicability, or the User&rsquo;s use of the Website, Services, or information accessed through it, shall be settled by arbitration in India before a sole arbitrator appointed by AIMSwasthya. The arbitration shall be conducted in accordance with the Arbitration and Conciliation Act, 1996.</strong></p>

<ul>
	<li>
	<p><strong>The seat of arbitration shall be New Delhi, India.</strong></p>
	</li>
	<li>
	<p><strong>The proceedings shall be conducted in English.</strong></p>
	</li>
	<li>
	<p><strong>The arbitral award shall be final and binding on all parties.</strong></p>
	</li>
</ul>

<p><strong>9.3 Jurisdiction</strong></p>

<p><strong>Subject to Clause 9.2, the courts at new Delhi, India shall have exclusive jurisdiction over any disputes arising out of or in relation to this Agreement, the User&rsquo;s use of the Website, or the Services.</strong></p>

<h2><strong>10. Data Protection Officer &amp; Grievance Officer</strong></h2>

<h3><strong>10.1 Data Protection Officer</strong></h3>

<p><strong>For any concerns or questions regarding the processing of your personal data or to exercise your data protection rights, you may contact AIMSwasthya&rsquo;s Data Protection Officer.</strong></p>

<p><strong>Data Protection Officer Details:<br />
Name: [Name of the Data Protection Officer]<br />
Designation: Data Protection Officer<br />
Email: &hellip;<br />
Contact Address: [Full Address of AIMSwasthya Office]<br />
Phone: [Data Protection Officer&#39;s Contact Number]</strong></p>

<p><strong>Our Data Protection Officer is dedicated to addressing data privacy concerns and ensuring compliance with applicable privacy laws.</strong></p>

<h3><strong>10.2 Grievance Officer</strong></h3>

<p><strong>In accordance with the Information Technology (Intermediary Guidelines and Digital Media Ethics Code) Rules, 2021, AIMSwasthya has appointed a Grievance Officer to address user complaints and resolve any issues related to the use of our services.</strong></p>

<p><strong>Grievance Officer Details:<br />
Name: [Name of the Grievance Officer]<br />
Designation: Grievance Officer<br />
Email: grievanceofficer@aimswasthya.com<br />
Contact Address: [Full Address of AIMSwasthya Office]<br />
Phone: [Grievance Officer&#39;s Contact Number]</strong></p>

<p><strong>Grievance Redressal Process:</strong></p>

<ol>
	<li>
	<p><strong>Users may raise complaints or concerns regarding any aspect of our services by contacting the Grievance Officer through the email address provided above.</strong></p>
	</li>
	<li>
	<p><strong>Complaints will be acknowledged within 24 hours of receipt.</strong></p>
	</li>
	<li>
	<p><strong>AIMSwasthya aims to resolve all grievances within 15 days from the date of receipt.</strong></p>
	</li>
	<li>
	<p><strong>For unresolved matters or escalations, the Grievance Officer may coordinate with relevant teams to ensure prompt and satisfactory resolution.</strong></p>
	</li>
</ol>

<p><strong>We are committed to addressing your concerns effectively and in compliance with applicable laws and regulations.</strong></p>

<h2><strong>11. Severability</strong></h2>

<p><strong>If any provision of this Agreement is held to be unenforceable by a court of competent jurisdiction or arbitral tribunal under applicable law, such provision shall be deemed excluded from this Agreement. The remainder of the Agreement shall continue to be valid and enforceable as if the excluded provision had never been a part of it.</strong></p>

<p><strong>However, in such an event, the Agreement shall be interpreted in a manner that best preserves the original intent and meaning of the excluded provision, to the maximum extent permitted by applicable law, as determined by the court or arbitral tribunal.</strong></p>

<h2><strong>12. Waiver</strong></h2>

<p><strong>No provision of this Agreement shall be deemed waived, nor shall any breach be excused, unless such waiver or consent is provided in writing and signed by AIMSwasthya.</strong></p>

<p><strong>Any consent or waiver granted by AIMSwasthya for a specific breach, whether express or implied, shall not be considered as:</strong></p>

<ul>
	<li>
	<p><strong>Consent to any other breach, whether similar or different.</strong></p>
	</li>
	<li>
	<p><strong>A waiver of any future breaches.</strong></p>
	</li>
</ul>

<p><strong>Failure by AIMSwasthya to enforce any provision of this Agreement shall not be construed as a waiver of its right to enforce that provision at a later time.</strong></p>
""";

  @override
  Widget build(BuildContext context) {
    return Consumer<TCPPViewModel>(builder: (context, tcCon, _) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              AppbarConst(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                title: '',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child:
                    HtmlWidget(widget.type == '1' ? termsOfUse : privacyPolicy),
              ),
            ],
          ),
        ),
      );
    });
  }
}

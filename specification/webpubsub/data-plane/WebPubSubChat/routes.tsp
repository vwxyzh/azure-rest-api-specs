import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

using Azure.Core.Traits;

namespace WebPubSubChat;

alias Operations = Azure.Core.ResourceOperations<Azure.Core.Traits.NoConditionalRequests &
  Azure.Core.Traits.SupportsRepeatableRequests &
  Azure.Core.Traits.NoClientRequestId>;

alias NonRepeatableOperations = Azure.Core.ResourceOperations<Azure.Core.Traits.NoConditionalRequests &
  Azure.Core.Traits.NoRepeatableRequests &
  Azure.Core.Traits.NoClientRequestId>;

/**
 * Chat operations.
 */
@tag("chat")
interface Chat {
  // --- Conversations ---

  /** Get conversation information. */
  @summary("Get conversation information.")
  getConversation is Operations.ResourceRead<ChatConversationInfo>;

  // --- Messages ---

  /** Query messages in a conversation. */
  @summary("Query messages in a conversation.")
  listMessages is Operations.ResourceList<
    ChatMessageInfo,
    ListQueryParametersTrait<{
      /** Last message ID for pagination. */
      @query
      lastMessageId?: string;

      /** First message ID for pagination. */
      @query
      firstMessageId?: string;

      /** Maximum number of messages to return. */
      @query
      @pageSize
      pageSize?: int32;
    }>
  >;

  /** Delete a message. */
  @summary("Delete a message.")
  deleteMessage is Operations.ResourceDelete<ChatMessageInfo>;

  /** Update a message. */
  @summary("Update a message.")
  updateMessage is Operations.ResourceCreateOrUpdate<ChatMessageInfo>;

  // --- Roles ---

  /** Query roles in a hub. */
  @summary("Query roles in a hub.")
  listRoles is Operations.ResourceList<
    ChatRoleInfo,
    ListQueryParametersTrait<{
      /** Maximum number of roles to return. */
      @query
      @pageSize
      pageSize?: int32;

      /** Continuation token for pagination. */
      @query
      continuationToken?: string;
    }>
  >;

  /** Get role information. */
  @summary("Get role information.")
  getRole is Operations.ResourceRead<ChatRoleInfo>;

  /** Create or replace a role. */
  @summary("Create or replace a role.")
  createOrReplaceRole is Operations.ResourceCreateOrReplace<ChatRoleInfo>;

  /** Delete a role. */
  @summary("Delete a role.")
  deleteRole is Operations.ResourceDelete<ChatRoleInfo>;

  // --- Rooms ---

  /** Create a new room with a service-generated ID. */
  @summary("Create a new room.")
  createRoom is NonRepeatableOperations.ResourceCreateWithServiceProvidedName<ChatRoomInfo>;

  /** Create or replace a room with a client-specified ID. */
  @summary("Create or replace a room.")
  createOrReplaceRoom is Operations.ResourceCreateOrReplace<ChatRoomInfo>;

  /** Get room information. */
  @summary("Get room information.")
  getRoom is Operations.ResourceRead<ChatRoomInfo>;

  /** Delete a room. */
  @summary("Delete a room.")
  deleteRoom is Operations.ResourceDelete<ChatRoomInfo>;

  // --- Room Members ---

  /** Get room members. */
  @summary("Get room members.")
  listRoomMembers is Operations.ResourceList<
    ChatRoomMember,
    ListQueryParametersTrait<{
      /** Maximum number of members to return. */
      @query
      @pageSize
      pageSize?: int32;

      /** Continuation token for pagination. */
      @query
      continuationToken?: string;
    }>
  >;

  /** Create or replace a room member. */
  @summary("Create or replace a room member.")
  createOrReplaceRoomMember is Operations.ResourceCreateOrReplace<ChatRoomMember>;

  /** Delete a room member. */
  @summary("Delete a room member.")
  deleteRoomMember is Operations.ResourceDelete<ChatRoomMember>;

  // --- Users ---

  /** Get a user's profile. */
  @summary("Get a user's profile.")
  getUser is Operations.ResourceRead<ChatUserProfile>;

  /** Create or replace a user. */
  @summary("Create or replace a user.")
  createOrReplaceUser is Operations.ResourceCreateOrReplace<ChatUserProfile>;

  /** Delete a user. */
  @summary("Delete a user.")
  deleteUser is Operations.ResourceDelete<ChatUserProfile>;
}

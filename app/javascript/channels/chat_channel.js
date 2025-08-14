import consumer from "./consumer"

// Get the chat room from the page data
const chatRoom = document.querySelector('[data-chat-room]')?.dataset.chatRoom;
const currentUsername = document.querySelector('[data-current-username]')?.dataset.currentUsername;

console.log("Chat room:", chatRoom);
console.log("Current username:", currentUsername);

if (chatRoom) {
  console.log("Creating subscription for room:", chatRoom);
  
  const subscription = consumer.subscriptions.create(
    { channel: "ChatChannel", room: chatRoom },
    {
      connected() {
        console.log("✅ Connected to ChatChannel for room:", chatRoom);
      },

      disconnected() {
        console.log("❌ Disconnected from ChatChannel");
      },

      rejected() {
        console.log("❌ Rejected from ChatChannel");
      },

      received(data) {
        console.log("📨 Received data:", data);
        
        const messagesContainer = document.getElementById('messages');
        if (messagesContainer) {
          // Remove empty state if it exists
          const emptyState = messagesContainer.querySelector('.text-center');
          if (emptyState) {
            emptyState.remove();
          }
          
          const messageDiv = document.createElement('div');
          const isOwnMessage = data.sender === currentUsername;
          
          messageDiv.className = `flex ${isOwnMessage ? 'justify-end' : 'justify-start'}`;
          messageDiv.innerHTML = `
            <div class="max-w-xs lg:max-w-md">
              <div class="${isOwnMessage ? 'bg-green-600 text-white' : 'bg-white border border-gray-200'} rounded-2xl px-4 py-3 shadow-sm">
                <p class="text-sm leading-relaxed">${data.message}</p>
                <p class="text-xs ${isOwnMessage ? 'text-green-100' : 'text-gray-500'} mt-2 text-right">${data.timestamp}</p>
              </div>
            </div>
          `;
          
          messagesContainer.appendChild(messageDiv);
          messagesContainer.scrollTop = messagesContainer.scrollHeight;
        }
      }
    }
  );
  
  // Make subscription available globally for debugging
  window.chatSubscription = subscription;
} else {
  console.log("❌ No chat room found on page");
}
